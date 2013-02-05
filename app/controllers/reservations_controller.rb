class ReservationsController < ApplicationController
  before_filter :authenticate_character!

  def index
    @reservations = Reservation.where(:character_id => current_character.id).order('created_at DESC')
    @runs = @reservations.collect { |r| r.run }
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def create
    unless run = Run.find(params[:id])
      flash[:error] = "Invalid ship specified."
      return redirect_to root_url
    end

    if run.reservation
      flash[:error] = "That ship has already been reserved."
      return redirect_to root_url
    end

    @reservation = Reservation.new( :character_id => current_character.id, :run_id => run.id )

    if @reservation.save
      redirect_to :back, notice: 'Reservation was successfully created.'
    else
      redirect_to :back
    end
  end

  def destroy
  end
end
