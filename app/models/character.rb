class Character < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :authentication_keys => [:name], :strip_whitespace_keys => [:name]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :password, :password_confirmation, :remember_me
  attr_accessible :name, :characterid

  validates_presence_of     :name
  validates_uniqueness_of   :name, :case_sensitive => false, :allow_blank => true, :if => :name_changed?

  validates_presence_of     :password, :on => :create
  validates_confirmation_of :password, :on => :create
  validates_length_of       :password, :within => Devise.password_length, :allow_blank => true

  has_many :notifications
  has_many :messages, :through => :notifications

  has_many :reservations
  has_many :reservation_comments

  scope :admins, where(:admin => true)

  def self.admins_except_current(current_character)
    Character.find(:all, :conditions => ["admin = ? and id != ?", true, current_character.id])
  end

  def notify(message)
    messages << message
  end

  def unread_notifications
    notifications.where(:read_at => nil)
  end
end
