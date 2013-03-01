class ReportController < ApplicationController
  before_filter :authenticate_character!
  before_filter :authenticate_admin!
  before_filter :check_igb, :only => :price

  def month
  end

  def price
    start = Run.where(:status_id => Status.sold).order('sell_date asc').first.sell_date
    @sold = Run.chart_data start
  end

private
  def check_igb
    if igb?
      flash[:error] = "Reports are currently unavailable when using the in-game browser."
      redirect_to root_url
    end
  end
end
