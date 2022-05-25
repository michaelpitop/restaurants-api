class Api::V1::RestaurantsController < Api::V1::BaseController
  before_action :set_restaurant, only: [ :show ]

  def show
  end

  def index
    @restaurants = policy_scope(Restaurant)
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant  # For Pundit
  end
end
