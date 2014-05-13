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

  it 'should have one to many seasons' do
    player = FactoryGirl.create(:player_with_seasons, seasons_count: 1)
    player.seasons.count.should == 1
    player = FactoryGirl.create(:player_with_seasons, seasons_count: 3)
    player.seasons.count.should == 3
  end

  it 'should correctly scope a season' do
    player = FactoryGirl.create(:player_with_seasons)
    season = player.seasons.first
    player.season(season.year).first.id.should == season.id
  end

end
