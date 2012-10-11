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
        Adhearsion::Events.after_initialized { connect }
        Adhearsion::Events.shutdown { shutdown }
      end

      private

      def connect
        logger.info "Connecting to XMPP"
        Adhearsion::Process.important_threads << Thread.new do
          EventMachine.run { client.connect }
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
