class API::ItemsController < ApiController

  before_action :authenticated?

  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item.to_json, status: :created
    else
      render json: { error: "Failed to create item", status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      render json: @item
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.permit(:list_id, :name)
  end
end
