require "adhearsion"
require "active_support/dependencies/autoload"

begin
  require 'blather/client/client'
  require 'blather/client/dsl'
rescue LoadError
  logger.fatal "XMPP support requires the \"blather\" gem."
  # Silence the abort so we don't get an ugly backtrace
  abort ""
end

require "adhearsion/xmpp/version"
require "adhearsion/xmpp/plugin"

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
      server         "localhost", :desc => "XMPP server hostname. May be omitted if server can be determined from JID. String."
      port           5222       , :desc => "XMPP server port. May be omitted if server can be determined from JID. Integer."

    end

    # Include the XMPP service in plugins initialization process
    init :xmpp do
      Initializer.new
    end
  end
end
