class HomeController < ApplicationController
  def index
    @ships = Run.not_sold.joins(:ship).order('ships.name').order('ship_number')
  end
end
