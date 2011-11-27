
module AhnXMPP
  
  ##
  # Adhearsion Plugin that defines the XMPP configuration options
  # and includes a hook to start the XMPP service in Adhearsion initialization process
  class Plugin < Adhearsion::Plugin
    extend ActiveSupport::Autoload

    autoload :Service
    autoload :Connection

    # Default configuration for XMPP connection.
    config :ahn_xmpp do
      jid      nil        , :desc => "XMPP connection: client/component JID to connect to. Must be a string"
      password nil        , :desc => "XMPP connection: password identifier. Must be a string"
      server   "localhost", :desc => "XMPP connection: destination host. Must be a string"
      port     5222       , :desc => "XMPP connection: destination port. Must be an integer"

    end
    
    # Include the XMPP service in plugins initialization process
    init :ahn_xmpp do
      Service.start
    end

  end

end