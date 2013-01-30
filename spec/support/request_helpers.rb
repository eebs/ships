require 'spec_helper'
include Warden::Test::Helpers

module RequestHelper

  def login_user(user)
    login_as user, scope: :character
    user
  end
end
