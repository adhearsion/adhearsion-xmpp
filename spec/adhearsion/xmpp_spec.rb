require 'spec_helper'

describe Adhearsion::XMPP do

  subject { Adhearsion::XMPP }

  it "should be a module" do
    subject.should be_kind_of Module
  end

end