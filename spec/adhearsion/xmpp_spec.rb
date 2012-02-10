require 'spec_helper'

describe Adhearsion::XMPP do

  subject { Adhearsion::XMPP }

  before :each do
    Adhearsion::XMPP.plugin = nil
  end

  it 'should delegate methods to the plugin connection' do
    Adhearsion::XMPP.plugin = mock :plugin
    connection = mock :connection
    Adhearsion::XMPP.plugin.should_receive(:connection).and_return connection
    connection.should_receive(:foo)

    Adhearsion::XMPP.foo
  end

  it 'should hold on to handlers until the plugin is initialized' do
    mock_handlers = lambda { :does_not_matter }
    Adhearsion::PunchblockPlugin.should_not_receive(:connection)

    Adhearsion::XMPP.register_handlers &mock_handlers
    Adhearsion::XMPP.handlers.should == mock_handlers
  end

  it 'should immediately register the handlers if the plugin is initialized' do
    mock_handlers = lambda { :does_not_matter }
    Adhearsion::XMPP.plugin = mock :plugin
    connection = mock :connection
    Adhearsion::XMPP.plugin.should_receive(:connection).and_return connection
    connection.should_receive(:register_handlers).once.with(&mock_handlers)

    Adhearsion::XMPP.register_handlers &mock_handlers
  end

end