class StaticPagesController < LayoutsController

  def home
    #ransackオブジェクトの生成
    @q = Spot.ransack(params[:q])
    @spots = @q.result(distinct: true)

    @prefectures = Prefecture.all
  end

  def demamd_sign_in
  end
end
