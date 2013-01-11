class ReportController < ApplicationController
  before_filter :authenticate_user!

  def month
  end

  def price
    @sold = Run.chart_data
  end
end
