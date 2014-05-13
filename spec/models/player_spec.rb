require File.join(File.dirname(__FILE__), '..', '/spec_helper')

describe Player do

  it 'should require a player_id' do
    player = Player.new
    player.should_not be_valid
    player = Player.new(:player_id => SecureRandom.hex)
    player.should be_valid
  end

  it 'should require a unique player_id' do
    player = Player.new(:player_id => 'slartibartfast')
    player.save!
    player = Player.new(:player_id => 'slartibartfast')
    player.should_not be_valid
  end

  it 'should correctly calculate batting average' do
    player = FactoryGirl.create(:player)
    season = Season.new(:player_id => player.player_id,
                            :year => 2011,
                            :league => 'NL',
                            :team => 'ATL',
                            :games => 100,
                            :at_bats => 599,
                            :hits => 201)
    season.save!
    player.batting_average(2011).should be_close(0.336, 0.001)
  end

  it 'should correctly scope batting average calculations to the relevant year' do

  end

  # TODO: test edge cases for batting average calculations

  it 'should correctly calculate slugging percentage' do
    player = FactoryGirl.create(:player)
    season = Season.new(:player_id => player.player_id,
                            :year => 2007,
                            :league => 'NL',
                            :team => 'CHI',
                            :games => 120,
                            :at_bats => 400,
                            :hits => 105,
                            :doubles => 20,
                            :triples => 3,
                            :home_runs => 24)
    season.save!
    player.slugging_percentage(2007).should be_close(0.508, 0.001)
  end

  # TODO: test edge cases for slugging percentage calculations

end
