require 'spec_helper'

describe Mbanker do

  describe "#create_session" do

    let(:username) { "a username" }
    let(:password) { "a password" }

    let(:crawler) { double("crawler") }
    let(:authenticator) { double("authenticator") }
    let(:session) { double("session") }

    before do
      Mbanker::Crawler.stub(:new) { crawler }
      Mbanker::Authenticator.stub(:new) { authenticator }
      Mbanker::Session.stub(:new) { session }
    end

    it "creates new crawler" do
      Mbanker::Crawler.should_receive(:new)
      Mbanker::create_session username, password
    end

    it "creates new authenticator with crawler and credentials" do
      Mbanker::Authenticator.should_receive(:new).with(crawler, username, password)
      Mbanker::create_session username, password
    end

    it "returns new session constructed with crawler and credentials" do
      Mbanker::Session.should_receive(:new).with(crawler, authenticator) { session }

      Mbanker::create_session(username, password).should == session
    end
  end
end
