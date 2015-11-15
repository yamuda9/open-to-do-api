require 'rails_helper'

RSpec.describe API::UsersController, type: :controller do
  before do
    User.destroy_all
  end

  context "unauthenticated users" do
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
      request.env['HTTP_AUTHORIZATION'] = @credentials
      
      @accept_json_header = { 'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s }
      @auth_header = { 'Authorization' => @credentials }
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
        get :index, {}, @accept_json_header

        expect( response.status ).to eq( 200 )
        expect( response.content_type ).to eq( Mime::JSON )
      
        # verify that all users that were created are returned
        usernames = credentials.map { | credential| credential[:username] }
        
        users_hash = json( response.body )[:users]
                  
        users_hash.each do | user_hash |
          expect( usernames ).to include( user_hash[:username] )
        end
      end

      xit "returns json content type" do
        get :index
        expect(response.content_type).to eq 'application/json'
      end

      xit "returns my_user serialized" do
        my_user = User.create!(username: "Joe", password: "password")
        get :index
        expect(UserSerializer.new(User.first).username).to eq(my_user.username)
      end
    end
  end
  
  def json( body )
    JSON.parse( response.body, symbolize_names: true )
  end
end
