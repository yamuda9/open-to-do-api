class API::ListsController < ApiController

  before_action :authenticated?

  def create
    @list = List.new(list_params)

    if @list.save
      render json: @list.to_json, status: :created
    else
      render json: { error: "Failed to create list", status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @list = List.find(params[:id])
      @list.destroy
      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    end
  end

  private

  def list_params
    params.permit(:user_id, :name)
  end
end
