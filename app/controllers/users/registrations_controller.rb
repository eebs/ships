class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :check_trust

private

  def check_trust
    if igb? && !igb.trusted?
      flash[:error] = "You must use the in-game browser, and trust this site to register."
      redirect_to new_user_registration_url
    end
  end
end