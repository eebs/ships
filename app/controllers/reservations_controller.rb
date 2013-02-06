class ReservationsController < ApplicationController
  before_filter :authenticate_character!

  before_filter :find_run, :only => [:new, :create]

  def index
    @reservations = Reservation.where(:character_id => current_character.id).order('created_at DESC')
    @runs = @reservations.collect { |r| r.run }
  end

  def show
    @reservation = Reservation.find(params[:id])
    unless @reservation.character == current_character
      flash[:error] = "You are not authorized to view that reservation."
      return redirect_to root_url
    end
  end

  def new
  end

  def create
    @reservation = Reservation.new( :character_id => current_character.id, :run_id => @run.id )

    if @reservation.save
      redirect_to reservation_path(@reservation), notice: 'Reservation was successfully created.'
    else
      redirect_to :back
    end
  end

  def destroy
  end

private

  def find_run
    unless @run = Run.find(params[:id])
      flash[:error] = "Invalid ship specified."
      return redirect_to root_url
    end

    if @run.reservation
      flash[:error] = "That ship has already been reserved."
      return redirect_to root_url
    end
  end
end
