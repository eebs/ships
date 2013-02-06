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
  end

  def update
    if @reservation.update_attributes(params[:reservation])
      redirect_to admin_reservation_path @reservation, notice: 'Reservation was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
  end
end
