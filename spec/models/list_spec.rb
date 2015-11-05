require 'rails_helper'

RSpec.describe List, type: :model do

  it { should belong_to(:user) }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(4) }

  describe "attributes" do
    it "should respond to body" do
      user = User.create!(username: "Joe", password: "password")
      list = user.lists.create!(name: "List")
      expect(list).to respond_to(:name)
    end
  end
end
