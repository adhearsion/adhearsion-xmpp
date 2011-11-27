require 'ahn_xmpp'

def reset_ahn_xmpp_config
  Adhearsion.config[:ahn_xmpp].jid      = nil
  Adhearsion.config[:ahn_xmpp].password = nil
  Adhearsion.config[:ahn_xmpp].server   = "localhost"
  Adhearsion.config[:ahn_xmpp].port     = 5222
end