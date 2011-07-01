require 'spec_helper'

module Mbanker
  describe Session do
    let(:accounts_list) { double("accounts_list").as_null_object }
    let(:accounts) { double("accounts").as_null_object }
    let(:crawler) { double("crawler").as_null_object }
    let(:authorizer) { double("authorizer").as_null_object }
    let(:persistent_crawler) { double("persistent_crawler").as_null_object }

    subject { Session.new crawler, authorizer }

    before do
      Mbanker::PersistentCrawler.stub(:new) { persistent_crawler }
      Mbanker::AccountsList.stub(:new) { accounts_list }
    end

    describe "#accounts" do
      it "returns new accounts list" do
        Mbanker::AccountsList.should_receive(:new) { accounts_list }
        accounts_list.stub(:accounts) { accounts }
        subject.accounts.should == accounts
      end

      it "initializes accounts list with persistent crawler" do
        Mbanker::AccountsList.should_receive(:new).with(persistent_crawler)
        subject.accounts
      end

      it "memoizes accounts list" do
        Mbanker::AccountsList.should_receive(:new).once
        subject.accounts
        subject.accounts
      end
    end
  end
end
