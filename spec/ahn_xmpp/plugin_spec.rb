require 'spec_helper'

describe AhnXMPP::Plugin do

  describe "while accessing the plugin configuration" do

    it "should retrieve a valid configuration instance" do
      Adhearsion.config.ahn_xmpp.should be_instance_of Loquacious::Configuration
    end

    it "should configure properly the jid" do
      Adhearsion.config[:ahn_xmpp].jid.should be_nil
    end

    it "should configure properly the password" do
      Adhearsion.config[:ahn_xmpp].password.should be_nil
    end

    it "should configure properly the server" do
      Adhearsion.config[:ahn_xmpp].server.should == "localhost"
    end

    it "should configure properly the port" do
      Adhearsion.config[:ahn_xmpp].port.should == 5222
    end

  end

  describe "while configuring a specific config value" do
    before do
      @jid      = Adhearsion.config[:ahn_xmpp].jid
      @password = Adhearsion.config[:ahn_xmpp].password
      @server   = Adhearsion.config[:ahn_xmpp].server
      @port     = Adhearsion.config[:ahn_xmpp].port
    end

    after do
      Adhearsion.config[:ahn_xmpp].jid      = @jid
      Adhearsion.config[:ahn_xmpp].password = @password
      Adhearsion.config[:ahn_xmpp].server   = @server
      Adhearsion.config[:ahn_xmpp].port     = @port
    end

    it "ovewrites properly the jid value" do
      Adhearsion.config[:ahn_xmpp].jid = "usera"
      Adhearsion.config[:ahn_xmpp].jid.should == "usera"
    end

    it "ovewrites properly the password value" do
      Adhearsion.config[:ahn_xmpp].password = "password"
      Adhearsion.config[:ahn_xmpp].password.should == "password"
    end

    it "ovewrites properly the server value" do
      Adhearsion.config[:ahn_xmpp].server = "www.myhost.com"
      Adhearsion.config[:ahn_xmpp].server.should == "www.myhost.com"
    end

    it "ovewrites properly the port value" do
      Adhearsion.config[:ahn_xmpp].port = 5223
      Adhearsion.config[:ahn_xmpp].port.should == 5223
    end
  end

  describe "while loading plugins" do
    it "should load the init block and start the service" do
      AhnXMPP::Plugin::Service.should_receive(:start).once.and_return true
      Adhearsion::Plugin.load
    end
  end
end