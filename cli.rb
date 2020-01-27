class Players::CLI
  attr_reader :player, :stats, :name

  def call
    Players::Scraper.scrape_all_stats
    greeting
    list_players
    menu
  end

  def greeting
    puts "Welcome to Top 50 stathub, press a number to learn more about a player."
  end

  def list_players
     Players::Player.all.each.with_index(1) do |player, i|
        puts "#{i}. #{player.name}--#{player.position}"
     end
   end

   def print_player(the_player)
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
   end

  def menu
    input = nil
    while input != "exit"
       puts "Welcome to todays Top 50 NBA players. For the players stats type the their number, type list to return or type exit:"
       input = gets.strip.downcase
      if input == "list"
         list_players
      elsif input.to_i.between?(1, Players::Player.all.size)
        the_player = Players::Player.find(input)
        print_player(the_player)
      elsif input == "exit"
        goodbye
      else
       puts "invalid command, type a number, list or exit."
      end
    end
  end

  def goodbye
    puts "Thanks for visiting, check back later for updated stats."
  end
end
