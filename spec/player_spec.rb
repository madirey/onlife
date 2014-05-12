require File.dirname(__FILE__) + '/spec_helper'
require 'securerandom'

describe Player do
  it 'should require a player_id' do
    p = Player.new
    p.should_not be_valid
    p = Player.new(:player_id => SecureRandom.hex)
    p.should be_valid
  end

  it 'should require a unique player_id' do
    p = Player.new(:player_id => 'slartibartfast')
    p.save!
    p = Player.new(:player_id => 'slartibartfast')
    p.should_not be_valid
  end

  it 'should correctly calculate batting average' do
    p = Player.new(:player_id => SecureRandom.hex)
    p.save!
    y = PlayerYear.new(:player_id => p.player_id,
                       :year => 2011,
                       :league => 'NL',
                       :team => 'ATL',
                       :games => 100,
                       :at_bats => 599,
                       :hits => 201)
    y.save!
    p.batting_average(2011).should be_close(0.336, 0.001)
  end

  # TODO: test edge cases for batting average calculations

  it 'should correctly calculate slugging percentage' do
    p = Player.new(:player_id => SecureRandom.hex)
    p.save!
    y = PlayerYear.new(:player_id => p.player_id,
                       :year => 2007,
                       :league => 'NL',
                       :team => 'CHI',
                       :games => 120,
                       :at_bats => 400,
                       :hits => 105,
                       :doubles => 20,
                       :triples => 3,
                       :home_runs => 24)
    y.save!
    p.slugging_percentage(2007).should be_close(0.508, 0.001)
  end

  # TODO: test edge cases for slugging percentage calculations

end
