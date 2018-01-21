class PrefecturesController < LayoutsController

  def index
    @prefectures = Prefecture.all

    #ransackオブジェクトの生成
    @q = Spot.ransack(params[:q])
    @spots = @q.result(distinct: true)
  end

  def show
    @prefecture = Prefecture.find(params[:id])
    @prefectures = Prefecture.all

    #ransackオブジェクトの生成
    @q = Spot.ransack(params[:q])
    @spots = @q.result(distinct: true)
  end
end
