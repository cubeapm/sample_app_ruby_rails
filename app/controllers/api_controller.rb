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


      def create_user
        user = User.create(name: params[:name])
        render json: user
      end

      def get_user
        user = User.find_by(id: params[:id])
        render json: user || {}
      end


      def redis
        $redis.set('foo', 'bar')
        render plain: "Redis called"
      end


    #   def kafka_produce
    #     producer = $kafka.producer
    #     producer.produce('raw_bytes', topic: 'sample_topic')
    #     producer.deliver_messages
    #     render plain: "Kafka produced"
    #   end

    #   def kafka_consume
    #     consumer = $kafka.consumer(group_id: 'my_consumer_group')
    
    #     consumer.subscribe('sample_topic')
    
    #     consumer.each_message do |message|
    #       Rails.logger.info "Received message: #{message.value}"
    #     end
    
    #     render plain: "Kafka consume started"
    #   end

    
    end

    