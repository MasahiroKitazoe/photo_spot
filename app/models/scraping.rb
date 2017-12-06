class Scraping
  def self.scraping_spot_information
    #配列の生成
    tmp_links = Array.new
    links = Array.new

    #スポットの都道府県別リンクの取得
    agent = Mechanize.new
    page = agent.get('http://ganref.jp/spot/photo/jpn/')
    elements = page.search('.jpnMap a')
    elements.each do |ele|
      tmp_links << ele.get_attribute('href')
    end

    #エリア括りのリンクを除外する
    i = 6 #エリア括りのリンクの数
    last_index = tmp_links.length
    while i < last_index do
      links << tmp_links[i]
      i += 1
    end

    #都道府県別のスポット名を取り出すメソッドを呼び出し
    links.each do |link|
      fetch_spot_names('http://ganref.jp/spot/photo/jpn/' + link.to_s)
    end
  end

  def self.fetch_spot_names(link)
    spot_links = Array.new

    agent = Mechanize.new
    page = agent.get(link)

    #都道府県名の格納
    element = page.at('#mainCntInner h1')
    prefecture = element.inner_text
    prefecture.slice!('の写真撮影スポット')

    elements = page.search('.spotList li')
    elements.each do |ele|
      spot_name = ele.inner_text
      spot = Spot.new
      spot.name = spot_name
      spot.prefecture = prefecture
      spot.save
    end
  end
end