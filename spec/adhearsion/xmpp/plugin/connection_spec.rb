require 'spec_helper'

describe Adhearsion::XMPP::Plugin::Connection do

  describe "while starting the connection" do

    subject {Adhearsion::XMPP::Plugin::Connection}

    let :blather_client do
      client = double(Blather::Client)
      client.should_receive(:register_handler).twice.and_return true
      client
    end

    let :events do
      events = double(Adhearsion::Events)
      events.should_receive(:register_namespace_name).with "/xmpp"
      events.should_receive(:register_callback).with(:after_initialized)
      events
    end

    it "should setup the proper values" do
      Blather::Client.should_receive(:setup).with("usera", "p", "localhost", 5222).and_return blather_client
      Adhearsion::Events = events

      subject.start "usera", "p", "localhost", 5222
    end

  end
end
