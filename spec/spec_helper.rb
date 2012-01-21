require 'adhearsion/xmpp'

module Adhearsion
  class PunchblockPlugin
  end
end

def reset_adhearsion_xmpp_config
  Adhearsion.config[:adhearsion_xmpp].jid      = nil
  Adhearsion.config[:adhearsion_xmpp].password = nil
  Adhearsion.config[:adhearsion_xmpp].server   = "localhost"
  Adhearsion.config[:adhearsion_xmpp].port     = 5222
end