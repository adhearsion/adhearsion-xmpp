require "adhearsion"
require "active_support/dependencies/autoload"
require "adhearsion/xmpp/version"

module Adhearsion
  ##
  # Adhearsion Plugin that defines the XMPP configuration options
  # and includes a hook to start the XMPP service in Adhearsion initialization process
  class XMPP
    extend ActiveSupport::Autoload
    autoload :Plugin
    autoload :Connection

    cattr_accessor :plugin

    # Default configuration for XMPP connection.
    config :xmpp do
      use_punchblock true       , :desc => "Re-use Punchblock's XMPP connection. Boolean."
      jid            nil        , :desc => "Client/component JID to connect to. String."
      password       nil        , :desc => "Password identifier. String."
      server         nil        , :desc => "XMPP server hostname. May be omitted if server can be determined from JID. String."
      port           nil        , :desc => "XMPP server port. May be omitted if server can be determined from JID. Integer."
    end

    delegate :connection, :to => Plugin

    # Include the XMPP service in plugins initialization process
    init :xmpp do
      self.plugin = Plugin.new
      run do
        self.plugin.run
      end
    end

    class << self
      def method_missing(m, *args, &block)
        plugin.connection.send m, *args, &block
      end
    end
  end
end
