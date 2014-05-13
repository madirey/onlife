require 'factory_girl'
require 'securerandom'

FactoryGirl.define do

  factory :player do

    # Set a unique player_id
    after(:build) do |player|
      player.player_id = SecureRandom.hex
    end

  end

end
