class Player < ActiveRecord::Base
  has_many :player_years, :foreign_key => 'player_id'

  self.primary_key = 'player_id'

  validates :player_id, presence: true
  validates :player_id, uniqueness: true

  def batting_average(year)
    year = PlayerYear.find_by year: year
    year.hits.to_f / year.at_bats
  end

  def slugging_percentage(year)
    year = PlayerYear.find_by year: year
    ((year.hits - year.doubles - year.triples - year.home_runs) + (2 * year.doubles) +
     (3 * year.triples) + (4 * year.home_runs)) / year.at_bats.to_f
  end

end

class PlayerYear < ActiveRecord::Base
  belongs_to :player, :foreign_key => 'player_id'

  validates :player_id, presence: true
  validates :year, presence: true
  validates :league, presence: true
  validates :team, presence: true
  validates :games, presence: true
end
