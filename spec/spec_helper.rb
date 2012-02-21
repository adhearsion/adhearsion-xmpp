require 'adhearsion/xmpp'

module Adhearsion
  class PunchblockPlugin
  end
end

def reset_adhearsion_xmpp_config
  Adhearsion.config[:xmpp].jid      = nil
  Adhearsion.config[:xmpp].password = nil
  Adhearsion.config[:xmpp].server   = "localhost"
  Adhearsion.config[:xmpp].port     = 5222
end