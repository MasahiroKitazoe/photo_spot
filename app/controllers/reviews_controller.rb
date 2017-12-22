class ReviewsController < ApplicationController

  def index
    
  end

  def show
    
  end

  def new
    @spot = Spot.where(id: params[:format])
    @review = Review.new(spot_id: params[:format])
  end

  def create

  end

    private
    def create_params
      
    end
end
