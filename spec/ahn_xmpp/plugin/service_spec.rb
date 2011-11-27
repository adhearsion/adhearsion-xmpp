require 'spec_helper'

describe AhnXMPP::Plugin::Service do

  describe "while initializing" do
    after do
      reset_ahn_xmpp_config
    end
    
    it "should raise an exception when no jid has been configured" do
      lambda {Adhearsion::Plugin.load}.should raise_error "Must supply a jid argument to the XMPP configuration"
    end

    it "should raise an exception when no password has been configured" do
      Adhearsion.config[:ahn_xmpp].jid = "usera"
      lambda {Adhearsion::Plugin.load}.should raise_error "Must supply a password argument to the XMPP configuration"
    end

    it "should raise an exception when no server has been configured" do
      Adhearsion.config[:ahn_xmpp].jid = "usera"
      Adhearsion.config[:ahn_xmpp].password = "p"
      Adhearsion.config[:ahn_xmpp].server = ""
      lambda {Adhearsion::Plugin.load}.should raise_error "Must supply a server argument to the XMPP configuration"
    end

    it "should raise an exception when an invalid port has been configured" do
      Adhearsion.config[:ahn_xmpp].jid = "usera"
      Adhearsion.config[:ahn_xmpp].password = "p"
      Adhearsion.config[:ahn_xmpp].port = "52222"
      lambda {Adhearsion::Plugin.load}.should raise_error "Must supply a valid port to the XMPP configuration"
    end
  end

  describe "when starting the XMPP connection" do    
    before do
      Adhearsion.config[:ahn_xmpp].jid      = "usera"
      Adhearsion.config[:ahn_xmpp].password = "p"
    end

    after do
      reset_ahn_xmpp_config
    end
    
    it "should call Connection.start method with the valid parameters" do
      AhnXMPP::Plugin::Connection.should_receive(:start).with("usera", "p", "localhost", 5222).and_return true
      Adhearsion::Plugin.load
    end

  end

end
