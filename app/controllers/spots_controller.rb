class SpotsController < LayoutsController
  def index
    @spots = Spot.all
    @prefectures = Prefecture.all
  end

  def show
    @spot = Spot.find(params[:id])
  end

  def new
    
  end

  def create
    
  end


    private

    def create_params
      
    end
end
