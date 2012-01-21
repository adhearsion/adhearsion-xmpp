require 'spec_helper'

describe Adhearsion::XMPP::Plugin do

  describe "while accessing the plugin configuration" do

    it "should retrieve a valid configuration instance" do
      Adhearsion.config.xmpp.should be_instance_of Loquacious::Configuration
    end

    it "should configure properly the jid" do
      Adhearsion.config[:xmpp].jid.should be_nil
    end

    it "should configure properly the password" do
      Adhearsion.config[:xmpp].password.should be_nil
    end

    it "should configure properly the server" do
      Adhearsion.config[:xmpp].server.should == "localhost"
    end

    it "should configure properly the port" do
      Adhearsion.config[:xmpp].port.should == 5222
    end

  end

  describe "while configuring a specific config value" do
    before do
      @jid      = Adhearsion.config[:xmpp].jid
      @password = Adhearsion.config[:xmpp].password
      @server   = Adhearsion.config[:xmpp].server
      @port     = Adhearsion.config[:xmpp].port
    end

    after do
      Adhearsion.config[:xmpp].jid      = @jid
      Adhearsion.config[:xmpp].password = @password
      Adhearsion.config[:xmpp].server   = @server
      Adhearsion.config[:xmpp].port     = @port
    end

    it "ovewrites properly the jid value" do
      Adhearsion.config[:xmpp].jid = "usera"
      Adhearsion.config[:xmpp].jid.should == "usera"
    end

    it "ovewrites properly the password value" do
      Adhearsion.config[:xmpp].password = "password"
      Adhearsion.config[:xmpp].password.should == "password"
    end

    it "ovewrites properly the server value" do
      Adhearsion.config[:xmpp].server = "www.myhost.com"
      Adhearsion.config[:xmpp].server.should == "www.myhost.com"
    end

    it "ovewrites properly the port value" do
      Adhearsion.config[:xmpp].port = 5223
      Adhearsion.config[:xmpp].port.should == 5223
    end
  end

  describe "when re-using Punchblock's connection" do
    it "should delegate the client accessor to PunchblockPlugin" do
      Adhearsion::PunchblockPlugin.should_receive(:client).and_return :mock_client
      Adhearsion::XMPP.client.should be :mock_client
    end
  end
end