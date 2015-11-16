require 'rails_helper'

RSpec.describe API::ListsController, type: :controller do

  context "authenticated users" do
    before do
      @user = create(:user)
      @list = create(:list, user: @user)
      @item = create(:item)

      @username = @user.username
      @password = @user.password

      basic = ActionController::HttpAuthentication::Basic
      @credentials = basic.encode_credentials( @username, @password )
      request.env['HTTP_AUTHORIZATION'] = @credentials
    end

    describe "POST create" do
      it "returns http success" do
        post :create, {user_id: @user.id, name: @list.name}
        expect(response).to have_http_status(:success)
      end

      it "returns json content type" do
        post :create, {user_id: @user.id, name: @list.name}
        expect(response.content_type).to eq 'application/json'
      end

      xit "creates a topic with the correct attributes" do
        post :create, {user_id: @user.id, name: @list.name}
        hashed_json = JSON.parse(response.body)
        expect(@user.lists.first.name).to eq hashed_json["MyString"]
      end
    end
  end
end
