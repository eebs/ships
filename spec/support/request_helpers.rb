require 'spec_helper'
include Warden::Test::Helpers

module RequestHelper
  def login_admin
    user = create(:admin)
    login(user)
    user
  end

  def login_user
    user = create(:character)
    login(user)
    user
  end

   def login(user)    
    login_as user, scope: :character
  end
end