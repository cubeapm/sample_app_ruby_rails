class ApiController < ApplicationController
    def home
        render plain: "Hello"
      end

      def param
        # Concept 1: Custom Tags on Active Span
        # Retrieve the auto-generated span for this HTTP request
        span = Datadog::Tracing.active_span
        if span
          span.set_tag('my.custom.param', params[:param])
        end

        render plain: "Got param #{params[:param]}"
      end
    
      def exception
        begin
          # Simulating a critical failure
          raise "Sample exception"
        rescue => e
          # Concept 2: Manual Error Tracking
          # If you catch an exception, you must explicitly tell Datadog it failed!
          span = Datadog::Tracing.active_span
          span.set_error(e) if span
          
          render plain: "Exception occurred and was tracked in Datadog", status: 500
        end
      end
    
      def api
        # Concept 3: Creating Custom Spans Programmatically
        # Wrap specific logic in perfectly timed sub-spans
        Datadog::Tracing.trace('external.api.call', resource: 'Fetch Localhost') do |span|
          begin
            Faraday.get('http://localhost:9000')
            render plain: "API called"
          rescue => e
            span.set_error(e) if span
            render plain: "API Failed", status: 500
          end
        end
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

    