class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :notification_count

  def notification_count
    if character_signed_in?
        @notification_count = current_character.unread_notifications.count
    end
  end

  # Override for CanCan
  def current_user
    current_character
  end

  def authenticate_admin!
    unless character_signed_in? && current_character.admin?
      flash[:error] = "You are not authorized to access that page."
      redirect_to root_url
    end
  end

  def notify(who, options = {})
    notifier = Notifier.new who, options
    yield notifier if block_given?
    notifier
  end

  rescue_from CanCan::AccessDenied do |exception|
        flash[:error] = exception.message
        redirect_to root_url
    end
end
