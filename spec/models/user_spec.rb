require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many(:lists) }

  # Shoulda tests for name
  it { should validate_presence_of(:username) }
  it { should validate_length_of(:username).is_at_least(1) }

  # Shoulda tests for password
  it { should validate_presence_of(:password) }
  it { should have_secure_password }
  it { should validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should respond to name" do
      user = User.create!(username: "Joe", password: "password")
      expect(user).to respond_to(:username)
    end
  end

  describe "invalid user" do
    it "should be an invalid user due to blank name" do
      user_with_invalid_name = User.new(username: "", password: "password")
      expect(user_with_invalid_name).to_not be_valid
    end
  end

  describe "#generate_auth_token" do
    it "creates a token" do
      user = User.create!(username: "Joe", password: "password")
      expect(user.auth_token).to_not be_nil
    end
  end
end
