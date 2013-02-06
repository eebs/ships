class Admin::ReservationsController < ApplicationController
  before_filter :authenticate_character!
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
      if @reservation.save
        redirect_to admin_reservation_path @reservation, notice: 'Reservation was successfully created.'
      else
        render action: "new"
      end
  end

  def update
    if @reservation.update_attributes(params[:reservation])
      redirect_to admin_reservation_path @reservation, notice: 'Reservation was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @reservation.destroy

    redirect_to admin_reservations_url
  end
end
