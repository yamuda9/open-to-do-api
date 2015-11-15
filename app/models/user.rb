class User < ActiveRecord::Base
  has_many :lists
  has_many :items, through: :lists

  validates :username, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }
end
