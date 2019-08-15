class Players::Player
  attr_accessor :name, :position, :avg_points, :team, :field_percentage, :assists, :rebounds, :steals, :turnovers, :blocks, :ft_percentage, :efficiency_rating, :url, :player 

   @@all = []

  def initialize(name)
    @@all << self
    @name = name
    @team = team
    @position = position
  end
   
  def save
    @@all << self
    self
  end
end  