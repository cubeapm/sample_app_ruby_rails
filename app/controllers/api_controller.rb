class ApiController < ApplicationController
    def home
        render plain: "Hello"
      end

      def param
        render plain: "Got param #{params[:param]}"
      end
    
      def exception
        raise "Sample exception"
      end
    
      def api
        Faraday.get('http://localhost:9000')
        render plain: "API called"
      end

      def redis
        $redis.set('foo', 'bar')
        render plain: "Redis called"
      end

      def mysql
        result = ActiveRecord::Base.connection.execute("SELECT NOW()")
        current_time = result.first.first
        render plain: current_time
      end
    
    end

    