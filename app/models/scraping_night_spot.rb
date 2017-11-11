class ScrapingNightSpot
  def self.scraping_spot_information
    #配列の生成
    tmp_links = Array.new
    links = Array.new

    #スポットの都道府県別リンクの取得
    agent = Mechanize.new
    page = agent.get('https://www.nightview.info/')
    elements = page.search('#map_zenkoku table td a')
    elements.each do |ele|
      links << ele.get_attribute('href')
    end

    #都道府県別のスポット名を取り出すメソッドを呼び出し
    links.each do |link|
      get_spot_urls('https://www.nightview.info/' + link.to_s)
    end
  end

  def self.get_spot_urls(link)
    spot_links = Array.new
    agent = Mechanize.new
    page = agent.get(link)
    elements = page.search('#yakei_list a')
    elements.each do |ele|
      spot_links << ele.get_attribute('href')
    end
    spot_links.each do |link|
      fetch_spot_info('https://www.nightview.info/' + link.to_s)
    end
  end

  def self.fetch_spot_info(link)
    agent = Mechanize.new
    page = agent.get(link)

    #スポット名の取得
    element = page.at('.spot_name h1')
    spot_name = element.inner_text

    #都道府県名＆市区町村の取得
    pans = Array.new
    elements = page.search('.pan li a')
    elements.each do |ele|
      pans << ele.inner_text
    end
    prefecture = pans[2]
    city = pans[4]

    #緯度経度の取得
    latlng_ary = Array.new
    element = page.at('.ll')
    latlng = element.inner_text
    latlng_arr = latlng.split('／')
    lng = latlng_arr[0]
    lat = latlng_arr[1]
    lng.slice!('緯度：')
    lat.slice!('経度：')

    # スクレイピングしたデータの保存
    if Spot.where(name: spot_name).exists? then
      spot = Spot.where(name: spot_name).first_or_initialize
      create_rows(spot, spot_name, prefecture, city, lng, lat)
    else
      spot = Spot.new
      create_rows(spot, spot_name, prefecture, city, lng, lat)
    end
  end

  def self.create_rows(spot, spot_name, prefecture, city, lng, lat)
    spot.name = spot_name
    spot.prefecture = prefecture
    spot.city = city
    spot.longitude = lng
    spot.latitude = lat
    spot.save
  end
end