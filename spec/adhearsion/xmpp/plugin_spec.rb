require 'spec_helper'

describe Adhearsion::XMPP::Plugin do

  describe "while accessing the plugin configuration" do

    it "should retrieve a valid configuration instance" do
      Adhearsion.config.adhearsion_xmpp.should be_instance_of Loquacious::Configuration
    end

    it "should configure properly the jid" do
      Adhearsion.config[:adhearsion_xmpp].jid.should be_nil
    end

    it "should configure properly the password" do
      Adhearsion.config[:adhearsion_xmpp].password.should be_nil
    end

    it "should configure properly the server" do
      Adhearsion.config[:adhearsion_xmpp].server.should == "localhost"
    end

    it "should configure properly the port" do
      Adhearsion.config[:adhearsion_xmpp].port.should == 5222
    end

  end

  describe "while configuring a specific config value" do
    before do
      @jid      = Adhearsion.config[:adhearsion_xmpp].jid
      @password = Adhearsion.config[:adhearsion_xmpp].password
      @server   = Adhearsion.config[:adhearsion_xmpp].server
      @port     = Adhearsion.config[:adhearsion_xmpp].port
    end

    after do
      Adhearsion.config[:adhearsion_xmpp].jid      = @jid
      Adhearsion.config[:adhearsion_xmpp].password = @password
      Adhearsion.config[:adhearsion_xmpp].server   = @server
      Adhearsion.config[:adhearsion_xmpp].port     = @port
    end

    it "ovewrites properly the jid value" do
      Adhearsion.config[:adhearsion_xmpp].jid = "usera"
      Adhearsion.config[:adhearsion_xmpp].jid.should == "usera"
    end

    it "ovewrites properly the password value" do
      Adhearsion.config[:adhearsion_xmpp].password = "password"
      Adhearsion.config[:adhearsion_xmpp].password.should == "password"
    end

    it "ovewrites properly the server value" do
      Adhearsion.config[:adhearsion_xmpp].server = "www.myhost.com"
      Adhearsion.config[:adhearsion_xmpp].server.should == "www.myhost.com"
    end

    it "ovewrites properly the port value" do
      Adhearsion.config[:adhearsion_xmpp].port = 5223
      Adhearsion.config[:adhearsion_xmpp].port.should == 5223
    end
  end

  describe "while loading plugins" do
    it "should load the init block and start the service" do
      Adhearsion::XMPP::Plugin::Service.should_receive(:start).once.and_return true
      Adhearsion::Plugin.load
    end
  end
end