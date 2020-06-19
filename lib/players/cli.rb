class Players::CLI
  attr_reader :player, :stats, :name

  def call
    Players::Scraper.scrape_all_stats
    greeting
    menu
  end

  def greeting
    puts "Welcome to Top 50 stathub, here you can view stats from the top players across the league."
  end

  def list_players
     Players::Player.all.each.with_index(1) do |player, i|
       if (i <= 50)
        puts "#{i}. #{player.name}(#{player.position})"
      end 
     end
   end

   def print_player(the_player)
    puts <<~HEREDOC

      This is #{the_player.name}'s player card

          Position: #{the_player.position}
          Team: #{the_player.team}
          Points Per Game: #{the_player.avg_points}
          Shooting Percentage: #{the_player.field_percentage}%
          Assists Per Game: #{the_player.assists}
          Rebounds Per Game: #{the_player.rebounds}
          Steals Per Game: #{the_player.steals}
          Turnovers Per Game: #{the_player.turnovers}
          Blocks Per Game: #{the_player.blocks}
          Free Throw Percentage: #{the_player.ft_percentage}%
          Player Efficiency Rating: #{the_player.efficiency_rating}

      For more info visit #{the_player.name}'s profile here: #{the_player.url}

          HEREDOC
   end

  def menu
    input = nil
    while input != "exit"
       puts "Select a player from todays top 50 NBA players. For a players stats type the the corresponding number. When you are done, just type exit:
       "
       list_players
       input = gets.strip.downcase
      if input.to_i.between?(1, Players::Player.all.size)
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
    puts "Thanks for visiting, check back tomorrow for updated stats."
  end
end
