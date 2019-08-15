class Players::CLI
  attr_reader :player, :stats, :name 
  
  def call 
    greeting 
    puts "List of NBA players"
    list_players
    stats
  end 
  
  def greeting 
    puts "Welcome to Top 50 stathub, press a number to learn more about a player"
  end 

  def list_players 
    @player = Players::Player.scrape_nba
    doc = Nokogiri::HTML(open("https://www.espn.com/nba/stats/player/_/table/offensive/sort/avgPoints/dir/desc"))
    @names = doc.search("td.Table2__td a").collect(&:text)[0..49]
    @names.each.with_index(1) do |player, index|
       puts "#{index}. #{player}"
    end 
   end

  def stats
    input = nil
    while input != "exit"
       puts "Welcome to todays Top 50 NBA players. For more stats type the player number, type list to return or type exit:"
       input = gets.strip.downcase
        the_player = Players::Player.scrape_nba[input.to_i-1]
        puts <<~HEREDOC
          Player: #{the_player.name} 
          Position: #{the_player.position} 
          Team: #{the_player.team}
          PointsPerGame: #{the_player.avg_points}  
          ShootingPercentage: #{the_player.field_percentage}%
          AssistsPerGame: #{the_player.assists} 
          ReboundsPerGame: #{the_player.rebounds}
          StealsPerGame: #{the_player.steals}
          TurnoversPerGame: #{the_player.turnovers}
          BlocksPerGame: #{the_player.blocks}
          FreeThrowPercentage: #{the_player.ft_percentage}%
          PlayerEfficiencyRating: #{the_player.efficiency_rating}
          PlayerUrl: #{the_player.url}
          This is #{the_player.name}'s info card 
          HEREDOC
            if input.to_i > 0 && input.to_i < 51
                    elsif input == "list"
                      list_players
                     elsif input == "exit"
                        goodbye
                    else 
                     puts "invalid command, type list or exit."
            end  
        end 
    end

  def goodbye
    puts "Thanks for visiting, stay tuned for updates."
  end 
end 



