require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  before do
    User.destroy_all
  end

  context "unauthenticated users" do
    it "GET index returns http unauthenticated" do
      get :index
      expect(response.status).to eq(401)
    end
  end

  context "authenticated users" do
    before do
      # controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("username", "password")
      allow(controller).to receive(:authenticated?).and_return(true)
    end

    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "returns json content type" do
        get :index
        expect(response.content_type).to eq 'application/json'
      end

      it "returns my_user serialized" do
        my_user = User.create!(username: "Joe", password: "password")
        get :index
        expect(UserSerializer.new(User.first).username).to eq(my_user.username)
      end
    end
  end
end
