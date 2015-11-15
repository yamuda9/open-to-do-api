require 'rails_helper'

RSpec.describe API::UsersController, type: :controller do
  before do
    User.destroy_all
  end

  context "unauthenticated users" do
    before do
      allow(controller).to receive(:authenticated?).and_return(true)
    end

    xit "GET index returns http unauthenticated" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  context "authenticated users" do
    before do
      @user = create(:user)
      @username = @user.username
      @password = @user.password
      basic = ActionController::HttpAuthentication::Basic
      @credentials = basic.encode_credentials( @username, @password )
      @accept_json_header = { 'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s }
      @auth_header = { 'Authorization' => @credentials }
      allow(controller).to receive(:authenticated?).and_return(true)
    end

    describe "GET /api/users" do
      it "returns http success" do
        # create some users

        credentials = [ { username: 'user1@example.com', password: 'password' }, { username: 'user2@example.com', password: 'password' } ]

        credentials.each do | credential |
          User.create( credential )
        end

        # retrieve the list of users
        get :index, {}, @accept_json_header.merge( @auth_header )

        expect( response.status ).to eq( 200 )
        expect( response.content_type ).to eq( Mime::JSON )

        # verify that all users that were created are returned
        usernames = credentials.map { | credential| credential[:username] }

        expect( assigns(:users).map(&:username) ).to include( usernames[0], usernames[1] )
      end

      xit "returns json content type" do
        get :index
        expect(response.content_type).to eq 'application/json'
      end

      xit "returns my_user serialized" do
        my_user = User.create!(username: "Joe", password: "password")
        get :index
        expect(UserSerializer.new(User.last).username).to eq(my_user.username)
      end
    end
  end
end
