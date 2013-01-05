class ReportController < ApplicationController
  def month
  end

  def price
    @sold = Run.chart_data
  end
end
