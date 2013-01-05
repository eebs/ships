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
end
