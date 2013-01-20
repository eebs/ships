class ReportController < ApplicationController
  before_filter :authenticate_character!
  before_filter :check_igb, :only => :price

  def month
  end

  def price
    @sold = Run.chart_data
  end

private
  def check_igb
    if igb?
      flash[:error] = "Reports are currently unavailable when using the in-game browser."
      redirect_to root_url
    end
  end
end
