require File.join(File.dirname(__FILE__), '..', '/spec_helper')

describe Season do
  it 'should require a player_id' do
    player = Player.first
    season = Season.new(:year => 2012,
                        :league => 'AL',
                        :team => 'SEA',
                        :games => 0)
    season.should_not be_valid
    season.player_id = player.player_id
    season.should be_valid
  end

  it 'should require a year' do
    player = Player.first
    season = Season.new(:player_id => player.player_id,
                        :league => 'AL',
                        :team => 'SEA',
                        :games => 0)
    season.should_not be_valid
    season.year = 2012
    season.should be_valid
  end

  # TODO: finish testing these permutations
  # TODO: also test data types and edge cases
end
