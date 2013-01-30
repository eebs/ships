require 'spec_helper'
include ApplicationHelper
include RequestHelper

describe "The home page" do

  describe "as guest" do
    before { visit root_path }
    subject { page }

    describe "with no runs" do
      it "should have content 'No ships need attention'" do
        should have_content 'No ships need attention'
      end
    end

    describe "with runs" do
    end
  end

  describe "with user" do
    let(:user) { login_user create(:character) }
    before { visit root_path }
    subject { page }

    it "should have current user" do
      user.should_not be_nil
    end

  end
end
