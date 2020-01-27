class Players::Player
  attr_accessor :name, :position, :avg_points, :team, :field_percentage, :assists, :rebounds, :steals, :turnovers, :blocks, :ft_percentage, :efficiency_rating, :url, :player

   @@all = []

  # def initialize
  #   @@all << self
  #   @name = name
  #   @team = team
  #   @position = position
  # end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.find(id)
    self.all[id.to_i - 1]
  end

  def self.find_by_name(player)
    self.all.detect do |ply|
      ply.player.downcase.strip == player.downcase.strip ||
      ply.player.split("").first.strip.downcase == player.downcase.strip
    end
  end
end
