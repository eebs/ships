class Run < ActiveRecord::Base
  attr_accessible :next_due, :notes, :sell_date, :sell_price, :ship_number, :start_date, :status_id, :ship_id

  belongs_to :ship
  belongs_to :status

  # Ensure associations exist
  validates :status_id, :presence => true
  validates :ship_id,   :presence => true

  validates :ship_number, :numericality => { :greater_than => 0 }

  # Ensure it's not a duplicate run
  validates_with RunValidator

  # Ensure sell price is greater than 0, only if it exists
  validates_each :sell_price do |record, attr, value|
    if value.present? && value < 0 then
        record.errors.add(attr, 'must be greater than zero or not be set')
    end
  end

  # Ensure we have a valid date
  validates_each :next_due, :sell_date, :start_date do |record, attr, value|
    if value.present? && !value.is_a?(ActiveSupport::TimeWithZone)
      record.errors.add(attr, 'must be a valid date')
    end
  end

  def self.sold_ordered
    if sold_status = Status.find_by_name('Sold')
      where('status_id = ?', sold_status.id).order('sell_date DESC')
    else
      []
    end
  end

  def self.sold
    if sold_status = Status.find_by_name('Sold')
      where('status_id = ?', sold_status.id)
    else
      []
    end
  end

  def self.chart_data(start = 2.month.ago)
    ships = Ship.all
    ships_data = {}

    ships.each do |ship|
      ships_data[ship.id] = where(ship_id: ship.id).prices_by_day(start)
    end

    (start.to_date..Date.today).map do |date|
      entry = { sell_date: date }
      ships.each do |ship|
        entry[ship.name.downcase.to_sym] = ships_data[ship.id][date]
      end
      entry
    end
  end

  def self.prices_by_day(start)
    runs = where(sell_date: start.beginning_of_day..Time.zone.now)
    runs = order.group("sell_date")
    runs = runs.select("sell_date, sum(sell_price) as total_price")
    runs.each_with_object({}) do |run, prices|
      prices[run.sell_date.to_date] = run.total_price
    end
  end

  def self.active
    sold = Status.find_by_name('Sold')
    where('status_id != ?', sold.id).order('next_due')
  end

  def self.inactive
    sold = Status.find_by_name('Sold')
    where(:status_id => sold.id).order('sell_date DESC')
  end
end
