module Adhearsion
  class XMPP
    class Plugin < Adhearsion::Plugin

      # Default configuration for XMPP connection.
      config :xmpp do
        enabled        true,  :desc => "Enable or disable the connection", :transform => Proc.new { |v| v == 'true' }
        use_punchblock true,  :desc => "Re-use Punchblock's XMPP connection. Boolean."
        jid            nil,   :desc => "Client/component JID to connect to. String."
        password       nil,   :desc => "Password identifier. String."
        server         nil,   :desc => "XMPP server hostname. May be omitted if server can be determined from JID. String."
        port           nil,   :desc => "XMPP server port. May be omitted if server can be determined from JID. Integer."
      end

      # Include the XMPP service in plugins initialization process
      init :xmpp, :after => :punchblock do
        if config.enabled
          Adhearsion::XMPP.plugin = Adhearsion::XMPP::Plugin.new
          Adhearsion::XMPP.handlers.each do |handler|
            Adhearsion::XMPP.connection.instance_eval &handler
          end unless Adhearsion::XMPP.handlers.nil?
        end
      end

      delegate :config, :to => self
      delegate :use_punchblock, :to => :config

      def initialize
        init_blather config.jid, config.password, config.server, config.port unless use_punchblock
      end

      def init_blather(jid, password, server, port)
        raise "Must supply a jid to the XMPP configuration" unless jid.present?
        raise "Must supply a password to the XMPP configuration" unless password.present?

        connection.setup jid, password, server, port
      end

      def connection
        if use_punchblock
          PunchblockPlugin.connection
        else
          @connection ||= Connection.new
        end
      end
    end
  end
end
