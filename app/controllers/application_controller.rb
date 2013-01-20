class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :notification_count

  def notification_count
    if character_signed_in?
        @notification_count = current_character.notifications.where(:read_at => nil).count
    end
  end

  # Override for CanCan
  def current_user
    current_character
  end

  rescue_from CanCan::AccessDenied do |exception|
        flash[:error] = exception.message
        redirect_to root_url
    end
end
