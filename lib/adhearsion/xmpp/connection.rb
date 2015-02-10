require 'blather/client/client'
require 'blather/client/dsl'

module Adhearsion
  class XMPP
    class Connection

      include Blather::DSL

      def initialize
        Blather.logger = logger
        Blather.default_log_level = :trace if Blather.respond_to? :default_log_level
        register_default_client_handlers
        @shutting_down = false
        Adhearsion::Events.after_initialized { connect }
        Adhearsion::Events.shutdown do
          @shutting_down = true
          shutdown
        end
      end

      private

      def connect
        Adhearsion::Process.important_threads << Thread.new do
          begin
            until @shutting_down
              logger.info "Connecting to XMPP"
              EventMachine.run { client.connect }
              logger.info "XMPP connection closed"
            end
          rescue Blather::Stream::ConnectionFailed
            reconnect_timer = Adhearsion.config.punchblock.reconnect_timer
            logger.error "XMPP connection failed. Retrying connection in #{reconnect_timer}s"
            sleep reconnect_timer
            retry
          end
        end
      end

      def register_default_client_handlers
        client.register_handler(:ready) do
          logger.info "Connected to XMPP server! Send messages to #{client.jid.stripped}."
        end
      end

    end
  end
end
