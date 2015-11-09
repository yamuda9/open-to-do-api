class Item < ActiveRecord::Base
  belongs_to :list

  validates :name, length: { minimum: 4 }, presence: true
end
