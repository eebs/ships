class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :notification_count

  def notification_count
    if user_signed_in?
        @notification_count = current_user.notifications.where(:read_at => nil).count
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
        flash[:error] = exception.message
        redirect_to root_url
    end
end
