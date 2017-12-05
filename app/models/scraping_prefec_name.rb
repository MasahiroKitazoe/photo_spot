class ScrapingPrefecName

  def self.scraping_prefec_name
    #配列の生成
    prefecture_names = Array.new

    #都道府県名のスクレイピング
    agent = Mechanize.new
    page = agent.get('https://www.jalan.net/')
    elements = page.search('.map-alternative dl dd a')

    #都道府県名を配列に格納
    elements.each do |ele|
      prefecture_names << ele.inner_text
    end

    #配列内の不要な要素を削除
    prefecture_names.pop

    #Prefectureテーブルに要素を保存
    prefecture_names.each do |prefec_name|
      prefecture = Prefecture.new
      prefecture.name = prefec_name
      prefecture.save
    end
  end
end