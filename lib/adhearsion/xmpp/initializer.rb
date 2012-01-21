 module Adhearsion
  module XMPP
    class Initializer
      def initialize
        @config ||= Adhearsion.config[:xmpp]
      end

      def run
        @config.use_punchblock ? run_punchblock : run_blather
      end

      def start_punchblock
        # Nothing needed here; everything is delegated
        nil
      end

      def start_blather
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
        @config.use_punchblock ? stop_punchblock : stop_blather
      end

      def stop_punchblock
        # We don't actually want to stop Punchblock from here.
        nil
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
