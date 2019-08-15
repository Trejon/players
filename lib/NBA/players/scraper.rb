 class Players::Scraper
  
  def self.get_page
    Nokogiri::HTML(open("https://www.espn.com/nba/stats/player/_/table/offensive/sort/avgPoints/dir/desc"))
  end 
  
   def self.scrape_players
     player = self.scrape_nba
     players = []
     players << player
     players
   end 

   def self.scrape_nba
     doc = self.get_page
     names_array = doc.css("td.Table2__td a").map(&:text)[0..49]
     team_array = doc.css("span.pl2.n10.athleteCell__teamAbbrev").map(&:text)[0..49]
     position_array = doc.css("div.position").collect(&:text)[0..49]
     avg_points_array = doc.css("td.Table2__td[4]").collect(&:text)[0..49]
     field_percentage_array = doc.css("td.Table2__td[7]").map(&:text)[0..49]
     assists_array = doc.css("td.Table2__td[15]").map(&:text)[0..49]
     rebounds_array = doc.css("td.Table2__td[14]").map(&:text)[0..49]
     steals_array = doc.css("td.Table2__td[16]").map(&:text)[0..49]
     turnovers_array = doc.css("td.Table2__td[18]").map(&:text)[0..49]
     blocks_array = doc.css("td.Table2__td[17]").map(&:text)[0..49]
     ft_percentage_array = doc.css("td.Table2__td[13]").map(&:text)[0..49]
     efficiency_rating_array = doc.css("td.Table2__td[21]").map(&:text)[0..49]
     url_array = doc.css("td.Table2__td a")[0..49].map{|player_name| player_name.attribute("href").value}

     names_array.map.with_index {|name, i| 
     player = Players::Player.new(name)
     player.position = position_array [i]
     player.team = team_array [i]
     player.avg_points = avg_points_array [i]
     player.field_percentage = field_percentage_array[i]
     player.assists = assists_array[i]
     player.rebounds = rebounds_array[i]
     player.steals = steals_array[i]
     player.turnovers = turnovers_array[i]
     player.blocks = blocks_array[i]
     player.ft_percentage = ft_percentage_array[i]
     player.efficiency_rating = efficiency_rating_array[i]
     player.url = url_array[i]
     player.save
     player}
   end
 end 