 class Players::Scraper

  def self.doc
    @@doc = Nokogiri::HTML(open("https://www.espn.com/nba/stats/player/_/table/offensive/sort/avgPoints/dir/desc"))
  end

   def self.scrape_players
     players = []
     players << self.scrape_all_stats
     players
   end

   def self.scrape_nba




     # names_array = doc.search("td.Table2__td a").map(&:text)[0..49]
     # team_array = doc.css("span.pl2.n10.athleteCell__teamAbbrev").map(&:text)[0..49]
     # position_array = doc.css("div.position").collect(&:text)[0..49]
     # avg_points_array = doc.css("td.Table2__td[4]").collect(&:text)[0..49]
     # field_percentage_array = doc.css("td.Table2__td[7]").map(&:text)[0..49]
     # assists_array = doc.css("td.Table2__td[15]").map(&:text)[0..49]
     # rebounds_array = doc.css("td.Table2__td[14]").map(&:text)[0..49]
     # steals_array = doc.css("td.Table2__td[16]").map(&:text)[0..49]
     # turnovers_array = doc.css("td.Table2__td[18]").map(&:text)[0..49]
     # blocks_array = doc.css("td.Table2__td[17]").map(&:text)[0..49]
     # ft_percentage_array = doc.css("td.Table2__td[13]").map(&:text)[0..49]
     # efficiency_rating_array = doc.css("td.Table2__td[21]").map(&:text)[0..49]
     # url_array = doc.css("td.Table2__td a")[0..49].map{|player_name| player_name.attribute("href").value}
     #
     # names_array.map.with_index {|name, i|
     # player = Players::Player.new(name)
     # player.position = position_array [i]
     # player.team = team_array [i]
     # player.avg_points = avg_points_array [i]
     # player.field_percentage = field_percentage_array[i]
     # player.assists = assists_array[i]
     # player.rebounds = rebounds_array[i]
     # player.steals = steals_array[i]
     # player.turnovers = turnovers_array[i]
     # player.blocks = blocks_array[i]
     # player.ft_percentage = ft_percentage_array[i]
     # player.efficiency_rating = efficiency_rating_array[i]
     # player.url = url_array[i]
     # player.save
     # player}
   end

   def self.scrape_all_stats
     (0..player_names.size).to_a.each do |i|
       player_name = player_names[i]
       player_team = player_teams[i]
       player_position = player_positions[i]
       player_point = player_points[i]
       player_field_percentage = player_field_percentages[i]
       player_assist = player_assists[i]
       player_rebound = player_rebounds[i]
       player_steal = player_steals[i]
       player_turnover = player_turnovers[i]
       player_block = player_blocks[i]
       player_ft_percentage = player_ft_percentages[i]
       player_efficiency_rating = player_efficiency_ratings[i]
       player_url = player_urls[i]


       player = Players::Player.new
       player.name = player_name
       player.team = player_team
       player.position = player_position
       player.avg_points = player_point
       player.field_percentage = player_field_percentage
       player.assists = player_assist
       player.rebounds = player_rebound
       player.steals = player_steal
       player.turnovers = player_turnover
       player.blocks = player_block
       player.ft_percentage = player_ft_percentage
       player.efficiency_rating = player_efficiency_rating
       player.url = player_url
       player.save
     end
    # player_names.each_with_index {|name, i|
    # player = Players::Player.new(name)
    # player.position = player_positions[i]
    # player.team = player_teams[i]
    # player.avg_points = player_points[i]
    # player.field_percentage = player_field_percentages[i]
    # player.assists = player_assists[i]
    # player.rebounds = player_rebounds[i]
    # player.steals = player_steals[i]
    # player.turnovers = player_turnovers[i]
    # player.blocks = player_blocks[i]
    # player.ft_percentage = player_ft_percentages[i]
    # player.efficiency_rating = player_efficiency_ratings[i]
    # player.url = player_urls[i]
    # player.save
    # player}

   end

   def self.player_names
     @@player_names ||= doc.search("tbody a.AnchorLink").collect{|e| e.text}
   end

   def self.player_teams
     @@player_teams ||= doc.search("span.pl2.n10.athleteCell__teamAbbrev").collect{|e| e.text}
   end

   def self.player_positions
     @@player_positions ||= doc.search("div.position").collect{|e| e.text}
   end

   def self.player_points
     @@player_points ||= doc.search("td.Table__TD[4]").collect{|e| e.text}
   end

   def self.player_field_percentages
     @@player_field_percentages ||= doc.search("td.Table__TD[7]").collect{|e| e.text}
   end

   def self.player_assists
     @@player_assists ||= doc.search("td.Table__TD[15]").collect{|e| e.text}
   end

   def self.player_rebounds
     @@player_rebounds ||= doc.search("td.Table__TD[14]").collect{|e| e.text}
   end

   def self.player_steals
     @@player_steals ||= doc.search("td.Table__TD[16]").collect{|e| e.text}
   end

   def self.player_turnovers
     @@player_turnovers ||= doc.search("td.Table__TD[18]").collect{|e| e.text}
   end

   def self.player_blocks
     @@player_blocks ||= doc.search("td.Table__TD[17]").collect{|e| e.text}
   end


   def self.player_ft_percentages
      @@player_ft_percentage ||= doc.search("td.Table__TD[13]").collect{|e| e.text}
   end

   def self.player_efficiency_ratings
     @@player_efficiency_ratings ||= doc.search("td.Table__TD[21]").collect{|e| e.text}
   end

   def self.player_urls
     @@player_urls ||= doc.search("td.Table__TD a").collect{|e| e.attribute("href").value}
   end
 end
