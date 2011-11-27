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

require "ahn_xmpp/version"
require "ahn_xmpp/plugin"

module AhnXMPP

end
