module Adhearsion
  class XMPP
    class Plugin < Adhearsion::Plugin

      # Default configuration for XMPP connection.
      config :xmpp do
        use_punchblock true       , :desc => "Re-use Punchblock's XMPP connection. Boolean."
        jid            nil        , :desc => "Client/component JID to connect to. String."
        password       nil        , :desc => "Password identifier. String."
        server         nil        , :desc => "XMPP server hostname. May be omitted if server can be determined from JID. String."
        port           nil        , :desc => "XMPP server port. May be omitted if server can be determined from JID. Integer."
      end

      # Include the XMPP service in plugins initialization process
      init :xmpp, :after => :punchblock do
        Adhearsion::XMPP.plugin = Adhearsion::XMPP::Plugin.new
        Adhearsion::XMPP.handlers.each do |handler|
          connection.instance_eval &handler
        end unless Adhearsion::XMPP.handlers.nil?
      end

      run :xmpp do
        Adhearsion::XMPP.plugin.run_plugin
      end

      def initialize
        @config ||= Adhearsion.config[:xmpp]
        init_blather unless @config.use_punchblock
      end

      def run_plugin
        run_blather unless @config.use_punchblock
      end

      def start_punchblock
        # Nothing needed here; everything is delegated
        nil
      end

      def init_blather
        raise "Must supply a jid argument to the XMPP configuration" if (@config.jid.nil? || @config.jid.empty?)
        raise "Must supply a password argument to the XMPP configuration" if (@config.password.nil? || @config.password.empty?)

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

      def connection
        @config.use_punchblock ?
          PunchblockPlugin.connection :
          Connection
      end

      def client
        @config.use_punchblock ? PunchblockPlugin.client : Connection.client
      end
    end
  end
end
