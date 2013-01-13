class HomeController < ApplicationController
  def index

    @sold = Run.sold_ordered
    @attention = get_attention
    @progress = get_progress

    @now = Time.zone.now
  end


  private

  def get_attention
    runs = Run.all
    runs.reject! do |e|
      e.next_due.empty? || !due_soon(e.next_due)
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

  def due_soon(next_due)
    begin
      time = Time.zone.parse(next_due)
      if time
        # An item is due within one day of the due date.
        return (time - 1.day).past?
      end
    rescue ArgumentError => e
    end
    return false
  end

  def get_progress
    ship_production = Status.find_by_name('Ship Production')
    component_prodction = Status.find_by_name('Component Production')
    if ship_production && component_prodction
      Run.where('status_id = ? OR status_id = ?', ship_production.id, component_prodction.id).order('next_due')
    else
      []
    end
  end

end
