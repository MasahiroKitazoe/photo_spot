class SpotsController < LayoutsController
  def index
    @spots = Spot.all
    @prefectures = Prefecture.all
  end

  def show
    @spot = Spot.find(params[:id])
  end

  def search
    @q = Spot.ransack(search_params)
    @results = @q.result
  end

  def new
    
  end

  def create
    
  end


    private

    def create_params
      
    end

    def search_params
      params.require(:q).permit(
        :name_cont,
        :prefecture_cont
        )
    end
end
