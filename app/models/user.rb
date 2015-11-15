class User < ActiveRecord::Base
  has_many :lists
  has_many :items, through: :lists

  validates :username, length: { minimum: 3, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password
end
