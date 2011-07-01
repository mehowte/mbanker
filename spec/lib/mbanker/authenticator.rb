require 'spec_helper'

module Mbanker
  describe Authenticator do
    let(:password) { double("password") }
    let(:login) { double("login") }
    let(:crawler) { double("crawler") }
    let(:search_result) { double("search_result") }
    let(:login_form) { double("login_form") }

    subject { Authenticator.new crawler, login, password }

    describe "#session_error_absent?" do
      it "searches for appropriate element on current page" do
        crawler.should_receive(:can_find?).with('.error.noSession') do
          search_result.as_null_object
        end
        subject.session_error_absent?
      end

      it "recognizes when error element is found" do
        crawler.stub(:can_find?) { true }
        subject.session_error_absent?.should == false
        crawler.stub(:can_find?) { false }
        subject.session_error_absent?.should == true
      end
    end

    describe "#authenticate!" do
      it "visits login page" do
        crawler.as_null_object.should_receive(:visit).with(:login)
        subject.authenticate!
      end
      it "submits credentials" do
        crawler.as_null_object.should_receive(:get_form) { login_form }
        login_form.should_receive(:customer).with(:login)
        login_form.should_receive(:password).with(:password)
        login_form.should_receive(:submit)
        subject.authenticate!
      end
    end


    describe "#unauthenticate!" do
      it "visits logout page" do
        crawler.should_receive(:visit).with(:logout)
        subject.unauthenticate!
      end
    end
  end
end

