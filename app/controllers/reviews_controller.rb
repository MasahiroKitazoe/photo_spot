class ReviewsController < ApplicationController

  def index
    
  end

  def show
    
  end

  def new
    @review = Review.new(spot_id: params[:format])
  end

  def create
    binding.pry
    Review.create(create_params)
  end

    private
    def create_params
      params.require(:review).permit(
        :rate,
        :comment
        )
    end
end
