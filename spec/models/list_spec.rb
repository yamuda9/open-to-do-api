require 'rails_helper'

RSpec.describe List, type: :model do

  it { should belong_to(:user) }

  it { should have_many(:items) }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(4) }

  describe "attributes" do
    it "should respond to name" do
      user = User.create!(username: "Joe", password: "password")
      list = user.lists.create!(name: "List")

      expect(list).to respond_to(:name)
    end
  end

  describe "actions" do
    it "should add items to lists" do
      user = User.create!(username: "Joe", password: "password")
      list = user.lists.create!(name: "List")
      item = Item.create!(name: "Item", list: list)

      expect(user.lists.first.items.first.name).to eq("Item")
    end
  end
end
