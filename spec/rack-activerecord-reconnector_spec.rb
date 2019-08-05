require 'spec_helper'

require 'active_record'
require 'rack'

require 'rack-activerecord-reconnector'

describe Rack::ActiveRecordReconnector do
  include Configure

  let(:app_without_exception) {
    Rack::Builder.new do
      use Rack::ActiveRecordReconnector
      run lambda {|env| [200, {}, []]}
    end
  }
  let(:app_with_exception) {
    Rack::Builder.new do
      use Rack::ActiveRecordReconnector
      run lambda {|env| raise StandardError}
    end
  }

  describe 'without exception' do
    before {
      mock(::ActiveRecord::Base.connection).reconnect!.never
    }
    it {
      app_without_exception.call({})
      RR.verify
    }
  end

  describe 'with exception' do
    before {
      mock(::ActiveRecord::Base.connection).reconnect!.once { ::ActiveRecord::Base.connection }
    }
    describe 'reconnect! called once' do
      it {
        begin
          app_with_exception.call({})
        rescue StandardError => e
          RR.verify
        end
      }
    end
    describe 'debug logging' do
      let(:app_with_debug) {
        Rack::Builder.new do
          use Rack::ActiveRecordReconnector, debug: true, logger: Logger.new(STDOUT, level: Logger::DEBUG)
          run lambda {|env| raise StandardError}
        end
      }
      it {
        begin
          app_with_debug.call({})
        rescue StandardError => e
          RR.verify
        end
      }
    end
  end

  describe '#detect_log_level' do
    describe '{:debug => true, :detect_log_level => nil}' do
      it {
        assert {
          :debug == Rack::ActiveRecordReconnector.new(proc {}).detect_log_level({:debug => true})
        }
      }
    end

    describe '{:debug => true, :detect_log_level => :warn}' do
      it {
        assert {
          :warn == Rack::ActiveRecordReconnector.new(proc {}).detect_log_level({:debug => true, :log_level => :warn})
        }
      }
    end

    describe 'nothing' do
      it {
        assert {
          Rack::ActiveRecordReconnector.new(proc {}).detect_log_level().nil?
        }
      }
    end
  end
end
