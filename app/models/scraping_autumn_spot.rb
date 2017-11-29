class ScrapingAutumnSpot

  def self.scraping_spot_information
    #配列の生成
    links = Array.new

    #北海道スポットのリンクを取得
    agent = Mechanize.new
    page = agent.get('https://koyo.walkerplus.com/')
    element = page.at('.prefectly_canvas div h3 a')
    links << element.get_attribute('href')

    #北海道以外のスポットのリンクを取得
   elements = page.search('.pref li a')
   elements.each do |ele|
    links << ele.get_attribute('href')
   end

    #エリア別のリンクを取得するメソッドを呼び出し
    links.each do |link|
      get_spot_page_urls('https://koyo.walkerplus.com' + link.to_s)
    end
  end

  def self.get_spot_page_urls(link)
    #配列の生成
    page_links = Array.new

    #スポットのページネーションのリンク取得
    agent = Mechanize.new
    page = agent.get(link)
    elements = page.search('.pager .inline_list .lists a')
    elements.each do |ele|
      page_links << ele.get_attribute('href')
    end

    #重複リンクの削除
    page_links.pop

    #スポットのリンクを取得するメソッド呼び出し
    page_links.each do |page_link|
      get_spot_urls(link + page_link.to_s)
    end
  end

  def self.get_spot_urls(link)
    #配列の生成
    spot_links = Array.new

    #スポットのリンクを取得
    agent = Mechanize.new
    page = agent.get(link)
    elements = page.search('article a')
    elements.each do |ele|
      spot_links << ele.get_attribute('href')
    end

    #不要なリンクの除外
    spot_links.pop

    #スポットのマップのリンクを取得するメソッド呼び出し
    spot_links.each do |spot_link|
      fetch_spot_information('https://koyo.walkerplus.com' + spot_link.to_s + 'map.html')
    end
  end

  def self.fetch_spot_information(link)
    #配列の生成
    location_links = Array.new

    #ページ情報を取得
    agent = Mechanize.new
    page = agent.get(link)

    #スポット名の取得
    spot_name = page.at('.name').inner_text
    spot_name.slice!('地図-')
    spot_name.slice!('の紅葉')

    #都道府県名&市区町村名の取得
    tmp_location = page.search('.clearfix .area').inner_text
    location_links = tmp_location.split('・')
    prefecture = location_links[0]
    city = location_links[1]
    city.slice!('${ content }')

    # スクレイピングしたデータの保存
    if Spot.where(name: spot_name).exists? then
      spot = Spot.where(name: spot_name).first_or_initialize
      create_rows(spot, spot_name, prefecture, city)
    else
      spot = Spot.new
      create_rows(spot, spot_name, prefecture, city)
    end
  end

  def self.create_rows(spot, spot_name, prefecture, city)
    spot.name = spot_name
    spot.prefecture = prefecture
    spot.city = city
    spot.save
  end
end