require "adhearsion"
require "active_support/dependencies/autoload"
require "adhearsion/xmpp/version"

module Adhearsion
  ##
  # Adhearsion Plugin that defines the XMPP configuration options
  # and includes a hook to start the XMPP service in Adhearsion initialization process
  class XMPP < Adhearsion::Plugin
    extend ActiveSupport::Autoload
    autoload :Initializer
    autoload :Connection

    # Default configuration for XMPP connection.
    config :xmpp do
      use_punchblock true       , :desc => "Re-use Punchblock's XMPP connection. Boolean."
      jid            nil        , :desc => "Client/component JID to connect to. String."
      password       nil        , :desc => "Password identifier. String."
      server         nil        , :desc => "XMPP server hostname. May be omitted if server can be determined from JID. String."
      port           nil        , :desc => "XMPP server port. May be omitted if server can be determined from JID. Integer."

    end

    # Include the XMPP service in plugins initialization process
    init :xmpp do
      xmpp = Initializer.new
      run do
        xmpp.run
      end
    end
  end
end
