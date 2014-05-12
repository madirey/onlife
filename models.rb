class Player < ActiveRecord::Base
  self.primary_key = 'player_id'

  validates :player_id, presence: true
  validates :player_id, uniqueness: true
end

class PlayerYear < ActiveRecord::Base
  belongs_to :player

  validates :player_id, presence: true
  validates :year, presence: true
  validates :league, presence: true
  validates :team, presence: true
  validates :games, presence: true
end
