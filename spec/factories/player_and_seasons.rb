require 'factory_girl'
require 'securerandom'

FactoryGirl.define do

  factory :season do

    after(:build) do |season|
      season.year   = (2007..2012).to_a.sample
      season.league = ['NL', 'AL'].sample
      season.team   = ['ATL', 'PHI', 'TOR', 'SEA', 'CLE'].sample
    end

  end

  factory :player do

    after(:build) do |player|
      player.player_id = SecureRandom.hex
    end

    factory :player_with_seasons do

      ignore do
        seasons_count 3
      end

      after(:create) do |player, evaluator|
        create_list(:season, evaluator.seasons_count, player: player)
      end

    end

  end

end
