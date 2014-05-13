require File.join(File.dirname(__FILE__), '..', '/spec_helper')

describe PlayerYear do
  it 'should require a player_id' do
    p = Player.first
    y = PlayerYear.new(:year => 2012,
                       :league => 'AL',
                       :team => 'SEA',
                       :games => 0)
    y.should_not be_valid
    y.player_id = p.player_id
    y.should be_valid
  end

  it 'should require a year' do
    p = Player.first
    y = PlayerYear.new(:player_id => p.player_id,
                       :league => 'AL',
                       :team => 'SEA',
                       :games => 0)
    y.should_not be_valid
    y.year = 2012
    y.should be_valid
  end

  # TODO: finish testing these permutations
  # TODO: also test data types and edge cases
end
