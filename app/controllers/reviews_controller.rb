class ReviewsController < ApplicationController
   before_action :authenticate_user!, only: :new

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
end
