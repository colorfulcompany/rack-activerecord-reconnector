require "rack/active_record_reconnector/version"

module Rack
  class ActiveRecordReconnector
    #
    # [param] Rack::Application app
    # [param] Hash options
    #
    def initialize(app, options = {})
      @app         = app
      @log_level ||= detect_log_level(options)
      if options.has_key?(:logger) && !@log_level.nil?
        @logger  ||= options[:logger]
      end
    end
    attr_reader :logger, :log_level

    #
    # [param]  Hash options
    # [return] Symbol or nil
    #
    def detect_log_level(options = {})
      if options.has_key? :log_level
        options[:log_level]
      else
        if options.has_key? :debug
          options[:debug] ? :debug : nil
        end
      end
    end

    #
    # [param]  Hash env
    # [return] Rack::Response
    #
    def call(env)
      begin
        @app.call(env)
      rescue Exception => e
        logger.send(log_level, "ActiveRecord reconnect ! by #{e.inspect} from #{e.backtrace.first}") if logger
        ::ActiveRecord::Base.connection.reconnect!
        raise e
      end
    end
  end
end
