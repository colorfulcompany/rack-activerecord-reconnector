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
    it {
      begin
        app_with_exception.call({})
      rescue StandardError => e
        RR.verify
      end
    }
  end
end
