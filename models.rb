class Player < ActiveRecord::Base
  self.primary_key = 'player_id'
end

class PlayerYear < ActiveRecord::Base
  belongs_to :player

  validates :year, presence: true
  validates :league, presence: true
  validates :team, presence: true
  validates :games, presence: true
end
