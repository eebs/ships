class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :authentication_keys => [:email], :strip_whitespace_keys => [:email]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  attr_accessible :admin

  has_many :notifications
  has_many :messages, :through => :notifications

  def notify(message)
    if message.instance_of? Message
      messages << message
    end
  end
end
