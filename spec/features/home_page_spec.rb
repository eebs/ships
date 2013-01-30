require 'spec_helper'
include ApplicationHelper
include RequestHelper

describe "The home page" do

  describe "with user" do
    let(:user) { login_user create(:character) }

    it "should have current user" do
      user.should_not be_nil
    end
  end
end
