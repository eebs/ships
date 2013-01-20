class NotificationsController < ApplicationController
  before_filter :authenticate_either!

  def index
    if user_signed_in?
      @notifications = current_user.notifications.find(:all, :order => 'created_at DESC, id')
    else
      @notifications = []
    end
  end

  def dismiss
    @notification = Notification.find(params[:id])
    @notification.read_at = Time.zone.now
    @notification.save
    redirect_to notifications_url
  end

private

  def authenticate_either!
    if !(user_signed_in? || character_signed_in?)
      authenticate_character!
    end
  end
end 
