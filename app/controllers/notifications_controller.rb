class NotificationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @notifications = current_user.notifications.find(:all, :order => 'created_at DESC, id')
  end

  def dismiss
    @notification = Notification.find(params[:id])
    @notification.read_at = Time.zone.now
    @notification.save
    redirect_to notifications_url
  end
end 
