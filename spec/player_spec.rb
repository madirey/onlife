require File.dirname(__FILE__) + '/spec_helper'
require 'securerandom'

describe Player do
  it 'should require a player_id' do
    puts ENV['RACK_ENV']
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
end
