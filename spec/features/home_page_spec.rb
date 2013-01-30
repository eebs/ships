require 'spec_helper'
include ApplicationHelper
include RequestHelper

describe "The home page" do

  describe "with user" do
    let(:user) { login_user }

    it "should allow access" do
      visit edit_character_registration_path(user)
    end
  end
end