require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do

  context "unauthenticated users" do
    it "GET index returns http unauthenticated" do
      get :index
      expect(response).to have_http_status(401)
    end
  end

  context "authenticated users" do
    my_user = User.create!(username: "Joe", password: "password")

    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("Joe","password")
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

      it "returns my_post serialized" do
        get :index
        expect([my_user].to_json).to eq response.body
      end
    end
  end
end
