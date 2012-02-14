require 'spec_helper'

describe Adhearsion::XMPP do

  subject { Adhearsion::XMPP }

  before :each do
    Adhearsion::XMPP.plugin   = nil
    Adhearsion::XMPP.handlers = nil
  end

  it 'should delegate methods to the plugin connection' do
    Adhearsion::XMPP.plugin = mock :plugin
    connection = mock :connection
    Adhearsion::XMPP.plugin.should_receive(:connection).and_return connection
    connection.should_receive(:foo)

    Adhearsion::XMPP.foo
  end

  it 'should hold on to a handler before the plugin is initialized' do
    mock_handler = lambda { :does_not_matter }
    Adhearsion::PunchblockPlugin.should_not_receive(:connection)

    Adhearsion::XMPP.register_handlers &mock_handler
    Adhearsion::XMPP.handlers.pop.should be mock_handler
  end

  it 'should hold on to multiple handlers' do
    handler1 = lambda { :does_not_matter }
    handler2 = lambda { :still_does_not_matter }

    Adhearsion::XMPP.register_handlers &handler1
    Adhearsion::XMPP.register_handlers &handler2
    Adhearsion::XMPP.handlers.shift.should == handler1
    Adhearsion::XMPP.handlers.shift.should == handler2
  end

  it 'should immediately register the handlers if the plugin is initialized' do
    mock_handler = lambda { :does_not_matter }
    Adhearsion::XMPP.plugin = mock :plugin
    connection = mock :connection
    Adhearsion::XMPP.plugin.should_receive(:connection).and_return connection
    connection.should_receive(:instance_eval).once.with(&mock_handler)

    Adhearsion::XMPP.register_handlers &mock_handler
  end

  it 'should register all stored handlers' do
    handler1 = lambda { :does_not_matter }
    handler2 = lambda { :still_does_not_matter }

    Adhearsion::XMPP.register_handlers &handler1


    Adhearsion::XMPP.plugin = mock :plugin
    connection = mock :connection
    Adhearsion::XMPP.plugin.should_receive(:connection).twice.and_return connection
    connection.should_receive(:instance_eval).once.with(&handler1)
    connection.should_receive(:instance_eval).once.with(&handler2)

    Adhearsion::XMPP.register_handlers &handler2
  end

  it 'should raise ArgumentError if called without a block' do
    expect { Adhearsion::XMPP.register_handlers }.to raise_error ArgumentError
  end

end