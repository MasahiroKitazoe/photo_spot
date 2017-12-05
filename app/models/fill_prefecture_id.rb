class FillPrefectureId

  def self.fill_prefecture_id
    #配列の生成
    prefec_names = Array.new

    #都道府県名を配列に格納
    prefectures = Prefecture.all
    prefectures.each do |prefec|
      prefec_names << prefec.name
    end

    #Spotテーブルにprefecture_idを追加する
    prefec_names.each do |prefec_name|
      prefecture = Prefecture.find_by(name: prefec_name)
      spots = Spot.where('prefecture like(?)', "%#{prefec_name}%")
      spots.each do |spot|
        spot.prefecture_id = prefecture.id
        spot.save
      end
    end
  end
end