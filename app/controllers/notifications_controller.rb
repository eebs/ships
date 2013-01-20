class NotificationsController < ApplicationController
  before_filter :authenticate_character!

  def index
    @notifications = current_character.notifications.find(:all, :order => 'created_at DESC, id')
  end

  def dismiss
    @notification = Notification.find(params[:id])
    @notification.read_at = Time.zone.now
    @notification.save
    redirect_to notifications_url
  end
end 
