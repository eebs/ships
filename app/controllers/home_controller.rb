class HomeController < ApplicationController
  def index

    @sold = Run.sold_ordered
    @attention = get_attention
    @progress = get_progress

    
  end


  private

  def get_attention
    runs = Run.all
    runs.reject! do |e|
      e.next_due.empty? || Time.zone.parse(e.next_due).future?
    end
    runs.sort! do |a, b|
      if a.next_due.empty?
        1
      elsif b.next_due.empty?
        -1 
      else
        a.next_due <=> b.next_due
      end
    end
  end

  def get_progress
    if sold_status = Status.find_by_name('Ship Production')
      Run.where('status_id = ?', sold_status.id).order('sell_date DESC')
    else
      []
    end
  end

end
