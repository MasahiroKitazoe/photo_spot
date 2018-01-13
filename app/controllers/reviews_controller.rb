class ReviewsController < ApplicationController
   before_action :authenticate, only: :new

  def index
  end

  def show
  end

  def new
    @review = Review.new(spot_id: params[:format])
  end

  def create
    Review.create(create_params)
    session[:spot_id] = nil
    binding.pry
  end

    private
    def create_params
      params.require(:review).permit(
        :rate,
        :comment
        ).merge(spot_id: session[:spot_id])
    end

    def authenticate
      redirect_to static_pages_demand_sign_in_url unless user_signed_in?
    end
end
