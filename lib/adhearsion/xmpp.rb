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
      use_punchblock true       , :desc => "XMPP connection: re-use Punchblock's XMPP connection. Boolean."
      jid            nil        , :desc => "XMPP connection: client/component JID to connect to. Must be a string"
      password       nil        , :desc => "XMPP connection: password identifier. Must be a string"
      server         "localhost", :desc => "XMPP connection: destination host. Must be a string"
      port           5222       , :desc => "XMPP connection: destination port. Must be an integer"

    end

    # Include the XMPP service in plugins initialization process
    init :xmpp do
      Initializer.new
    end
  end
end
