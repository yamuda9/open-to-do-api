class List < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates :name, length: { minimum: 4 }, presence: true
  validates :user, presence: true
end
