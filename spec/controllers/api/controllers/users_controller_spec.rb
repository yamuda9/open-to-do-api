require 'rails_helper'

RSpec.describe API::UsersController, type: :controller do
  before do
    User.destroy_all
  end

  context "authenticated users" do
    before do
      @user = create(:user)
      @username = @user.username
      @password = @user.password

      basic = ActionController::HttpAuthentication::Basic
      @credentials = basic.encode_credentials( @username, @password )
      request.env['HTTP_AUTHORIZATION'] = @credentials
    end

    describe "GET /api/users" do
      it "returns http success" do
        # create some users

        credentials =
          [
            { username: 'user1@example.com',   password: 'password' },
            { username: 'user2@example.com',   password: 'password' },
            { username: 'someone@example.com', password: 'password' }
          ]

        credentials.each do | credential |
          User.create( credential )
        end

        # retrieve the list of users
        get :index

        expect( response.status ).to eq( 200 )
        expect( response.content_type ).to eq( Mime::JSON )

        # verify that all users that were created are returned
        usernames = credentials.map { | credential| credential[:username] }

        users_hash = json( response.body )[:users]

        users_hash.each do | user_hash |
          expect( usernames ).to include( user_hash[:username] )
        end
      end
    end

    describe "POST create" do
      it "returns http success" do
        post :create, {username: @user.username, password: @user.password}
        expect(response).to have_http_status(:success)
      end

      it "returns json content type" do
        post :create, {username: @user.username, password: @user.password}
        expect(response.content_type).to eq 'application/json'
      end

      xit "creates a topic with the correct attributes" do
        post :create, {username: @user.username, password: @user.password}
        hashed_json = JSON.parse(response.body)
        expect(@user.username).to eq hashed_json["someone@example.com"]
        expect(@user.password).to eq hashed_json["password"]
      end
    end
  end

  def json( body )
    JSON.parse( response.body, symbolize_names: true )
  end
end
