require "adhearsion"
require "active_support/dependencies/autoload"
require "adhearsion/xmpp/version"
require "adhearsion/xmpp/plugin" # Because the autoloader is lazy this never gets loaded!

module Adhearsion
  ##
  # Adhearsion Plugin that defines the XMPP configuration options
  # and includes a hook to start the XMPP service in Adhearsion initialization process
  class XMPP
    extend ActiveSupport::Autoload
    #autoload :Plugin
    autoload :Connection

    cattr_accessor :plugin, :handlers

    class << self
      def register_handlers(&block)
        raise ArgumentError, "You must supply a block" unless block_given?
        self.handlers ||= ThreadSafeArray.new
        handlers << block
        handlers.each do |handler|
          unless plugin.nil?
            # Plugin has already initialized.  Add these handlers directly.
            plugin.connection.instance_eval &handler
          end
        end
      end

      delegate :connection, :to => :plugin

      def method_missing(m, *args, &block)
        plugin.connection.send m, *args, &block
      end
    end
  end
end
