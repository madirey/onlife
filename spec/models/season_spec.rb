require File.join(File.dirname(__FILE__), '..', '/spec_helper')

describe Season do

  it 'should require a player reference' do
    player = FactoryGirl.create(:player_with_seasons, seasons_count: 1)
    season = player.seasons.first.dup
    season.player = nil
    season.should_not be_valid
  end

  it 'should require a year' do
    player = FactoryGirl.create(:player_with_seasons, seasons_count: 1)
    season = player.seasons.first.dup
    season.year = nil
    season.should_not be_valid
  end

  it 'should require a league' do
    player = FactoryGirl.create(:player_with_seasons, seasons_count: 1)
    season = player.seasons.first.dup
    season.league = ''
    season.should_not be_valid
  end

  it 'should require a team' do
    player = FactoryGirl.create(:player_with_seasons, seasons_count: 1)
    season = player.seasons.first.dup
    season.team = ''
    season.should_not be_valid
  end

  it 'should correctly calculate batting average' do
    player = FactoryGirl.create(:player_with_seasons, seasons_count: 1)
    season = player.seasons.first.dup
    season.games    = 100
    season.at_bats  = 599
    season.hits     = 201
    season.batting_average.should be_close(0.336, 0.001)
  end

  it 'should correctly calculate slugging percentage' do
    player = FactoryGirl.create(:player_with_seasons, seasons_count: 1)
    season = player.seasons.first.dup
    season.games     = 120
    season.at_bats   = 400
    season.hits      = 105
    season.doubles   = 20
    season.triples   = 3
    season.home_runs = 24
    season.slugging_percentage.should be_close(0.508, 0.001)
  end

end
