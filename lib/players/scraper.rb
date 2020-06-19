 class Players::Scraper

   def self.doc
     @@doc = Nokogiri::HTML(open("https://www.espn.com/nba/stats/player/_/table/offensive/sort/avgPoints/dir/desc"))
   end

   def self.scrape_players
     players = []
     players << self.scrape_all_stats
     players
   end

   def self.scrape_all_stats
     (0..player_names.size).to_a.each do |i|
      player = Players::Player.new

      player.name = player_names[i]
      player.team = player_teams[i]
      player.position = player_positions[i]
      player.avg_points = player_points[i]
      player.field_percentage = player_field_percentages[i]
      player.assists = player_assists[i]
      player.rebounds = player_rebounds[i]
      player.steals = player_steals[i]
      player.turnovers = player_turnovers[i]
      player.blocks = player_blocks[i]
      player.ft_percentage = player_ft_percentages[i]
      player.efficiency_rating = player_efficiency_ratings[i]
      player.url = player_urls[i]
      player.save
     end
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
