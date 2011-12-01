module Adhearsion
  module XMPP
    class Plugin
      class Service
        class << self

          ##
          # Start the XMPP connection
          def start
            raise "Must supply a jid argument to the XMPP configuration" if (config.jid.nil? || config.jid.empty?)
            raise "Must supply a password argument to the XMPP configuration" if (config.password.nil? || config.password.empty?)
            raise "Must supply a server argument to the XMPP configuration" if (config.server.nil? || config.server.empty?)
            raise "Must supply a valid port to the XMPP configuration" unless config.port.is_a? Integer

            Connection.extend Blather::DSL

            Connection.start config.jid, config.password, config.server, config.port
          end

          ##
          # Stop the XMPP connection
          def stop
            Connection.stop
          end

          private

          ##
          # Access to XMPP plugin configuration
          def config
            @config ||= Adhearsion.config[:adhearsion_xmpp]
          end

        end # class << self
      end # Service
    end # Plugin
  end # XMPP
end # Adhearsion
