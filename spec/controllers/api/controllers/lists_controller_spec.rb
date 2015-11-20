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

      it "creates a list with the correct attributes" do
        post :create, {user_id: @user.id, name: @list.name}
        hashed_json = JSON.parse(response.body)
        expect(@user.lists.first.name).to eq hashed_json["name"]
      end
    end

    describe "DELETE destroy" do
      before { delete :destroy, user_id: @user.id, id: @list.id }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns json content type" do
        expect(response.content_type).to eq 'application/json'
      end

      it "deletes list" do
        expect{ List.find(@list.id) }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end
