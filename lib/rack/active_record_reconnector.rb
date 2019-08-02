require "rack/active_record_reconnector/version"

module Rack
  class ActiveRecordReconnector
    #
    # [param] Rack::Application app
    #
    def initialize(app)
      @app = app
    end

    #
    # [param]  Hash env
    # [return] Rack::Response
    #
    def call(env)
      begin
        @app.call(env)
      rescue Exception => e
        ::ActiveRecord::Base.connection.reconnect!
        raise e
      end
    end
  end
end
