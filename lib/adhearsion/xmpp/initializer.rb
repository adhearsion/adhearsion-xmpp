 module Adhearsion
  module XMPP
    class Initializer
      def initialize
        @config ||= Adhearsion.config[:xmpp]
        init_blather unless @config.use_punchblock
      end

      def run
        run_blather unless @config.use_punchblock
      end

      def start_punchblock
        # Nothing needed here; everything is delegated
        nil
      end

      def init_blather
        raise "Must supply a jid argument to the XMPP configuration" if (@config.jid.nil? || @config.jid.empty?)
        raise "Must supply a password argument to the XMPP configuration" if (@config.password.nil? || @config.password.empty?)
        raise "Must supply a server argument to the XMPP configuration" if (@config.server.nil? || @config.server.empty?)
        raise "Must supply a valid port to the XMPP configuration" unless @config.port.is_a? Integer

        Connection.extend Blather::DSL
        Connection.start @config.jid, @config.password, @config.server, @config.port
      end

      ##
      # Stop the XMPP connection
      def stop
        stop_blather unless @config.use_punchblock
      end

      def stop_blather
        Connection.stop
      end

      def client
        @config.use_punchblock ? PunchblockPlugin.client : Connection.client
      end
    end
  end
end
