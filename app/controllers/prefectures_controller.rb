class PrefecturesController < LayoutsController

  def index
    @prefectures = Prefecture.all
  end

  def show
    @prefecture = Prefecture.find(params[:id])
  end
end
