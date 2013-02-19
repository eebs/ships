class NotificationsController < ApplicationController
  before_filter :authenticate_character!

  def index
    @notifications = current_character.notifications.includes(:message).find(:all, :order => 'created_at DESC, id')
  end

  def dismiss
    @notification = Notification.find(params[:id])
    unless @notification.character == current_character
      flash[:error] = "You are not authorized to access that page."
      return redirect_to root_url
    end
    @notification.read_at = Time.zone.now
    @notification.save
    redirect_to notifications_url
  end

  def dismiss_all
    current_character.notifications.where(:read_at => nil).each do |notification|
      notification.read_at = Time.zone.now
      notification.save
    end
    redirect_to notifications_url
  end
end 
