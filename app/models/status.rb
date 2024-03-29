class Status < ActiveRecord::Base
  attr_accessible :color, :name

  has_many :runs

  validates :name, :length => { :in => 2..60 }

  validates_each :color do |record, attr, value|
    record.errors.add(attr, "must be a valid hex color in the form '#XXX' or '#XXXXXX'") unless value =~ /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/
  end

  def self.sold
    find_by_name('Sold')
  end

  def self.on_market
    find_by_name('On Market')
  end

  def self.in_hanger
    find_by_name('In Hanger')
  end
end
