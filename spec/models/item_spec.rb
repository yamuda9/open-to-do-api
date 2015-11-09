require 'rails_helper'

RSpec.describe Item, type: :model do

  it { should belong_to(:list) }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(4) }

  describe "attributes" do
    it "should respond to name" do
      user = User.create!(username: "Joe", password: "password")
      list = user.lists.create!(name: "List")
      item = Item.create!(name: "Item", list: list)

      expect(item).to respond_to(:name)
    end
  end
end
