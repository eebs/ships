class ReservationCommentsController < ApplicationController
  before_filter :authenticate_commenter
  
  def create
    reservation = Reservation.find(params[:id])

    @reservation_comment = ReservationComment.new(params[:reservation_comment])
    @reservation_comment.reservation = reservation
    @reservation_comment.character = current_character

    if @reservation_comment.save
      redirect_to({:controller => 'reservations', :action => 'show', :id => reservation.id, :anchor => "reservation-comment-#{@reservation_comment.id}"}, notice: 'Comment added')
    else
      redirect_to reservation, :alert => 'Invalid comment'
    end
  end

private

  def authenticate_commenter
    reservation = Reservation.find(params[:id])
    unless reservation.character == current_character || current_character.admin?
      redirect_to :root, alert: 'You are not authorized to access that page.'
    end
  end
end
