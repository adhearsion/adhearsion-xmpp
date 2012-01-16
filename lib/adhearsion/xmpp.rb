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
  module XMPP
    extend ActiveSupport::Autoload
    autoload :Plugin
    autoload :Initializer

    class << self
      delegate :client, :to => Initializer
    end
  end
end
