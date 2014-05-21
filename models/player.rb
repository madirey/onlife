class Player < ActiveRecord::Base
  has_many :seasons

  validates :player_id, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  # Returns the player's statistical records for the specified year
  # NOTE: There could be more than one of these, if the player switched
  # teams.
  def season(year)
    seasons.where(year: year)
  end

end

class Season < ActiveRecord::Base
  belongs_to :player

  # Each of these records is for a year/league/team.
  # If the player switches teams, he may have more than one record
  # for a year.
  validates_uniqueness_of :player,
                          :scope => [:year, :league, :team],
                          :on => :update

  validates :player,    presence: true
  validates :year,      presence: true
  validates :league,    presence: true
  validates :team,      presence: true

  # Calculates and returns the player's batting average for this year/league/team
  def batting_average
    hits.to_f / at_bats
  end

  # Calculates and returns the player's slugging percentage for this year/league/team
  def slugging_percentage
    ((hits - doubles - triples - home_runs) + (2 * doubles) +
     (3 * triples) + (4 * home_runs)) / at_bats.to_f
  end

end
