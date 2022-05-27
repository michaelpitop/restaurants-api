class Api::V1::RestaurantsController < Api::V1::BaseController
  before_action :set_restaurant, only: [ :show, :destroy ]

  def show
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  def index
    @restaurants = policy_scope(Restaurant)
  end

  def update
    if @restaurant.update(restaurant_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @restaurant.destroy
    head :no_content
    # No need to create a `destroy.json.jbuilder` view
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant  # For Pundit
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address)
  end

  def render_error
    render json: { errors: @restaurant.errors.full_messages },
      status: :unprocessable_entity
  end
end
