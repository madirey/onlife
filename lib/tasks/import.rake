require 'csv'

namespace :import do

  desc 'Import player demographic data through 2012'
  task :players do |t|
    # Note that this will update players with new data, if run multiple times.
    # BUT it will NOT delete outdated records.
    puts 'Importing players (please be patient; this may take a while)...'

    CSV.foreach('data/Master-small.csv', :headers => true,
                                         :encoding => 'iso-8859-1:UTF-8') do |row|
      player_id = row['playerID']
      if player_id
        Player.where(:player_id => player_id).first_or_create! do |p|
          p.birth_year = row['birthYear']
          p.first_name = row['nameFirst']
          p.last_name  = row['nameLast']
        end
      end
    end

    puts 'Import complete.'
  end

  desc 'Import player statistics from 2007-2012'
  task :stats do |t|
    # Note that this will update existing players' statistics, if run more than once.
    # BUT again, it will not delete outdated records that no longer appear in the CSV.
    puts 'Importing player statistics (please be patient; this may take a while)...'

    CSV.foreach('data/Batting-07-12.csv', :headers => true,
                                          :encoding => 'iso-8859-1:UTF-8') do |row|

      # Below attributes represent a "unique" Season record
      player = Player.find_by!(player_id: row['playerID'])
      year   = row['yearID'].to_i
      league = row['league']
      team   = row['teamID']

      # If we have enough data to identify a unique entry, then record it
      if player && year && league && team
        player.seasons.where(
            :year   => year,
            :league => league,
            :team   => team).first_or_create! do |season|

          # Gather season data for this player/year/league/team
          season.player             = player
          season.games              = row['G'].to_i
          season.at_bats            = row['AB'].to_i
          season.runs               = row['R'].to_i
          season.hits               = row['H'].to_i
          season.doubles            = row['2B'].to_i
          season.triples            = row['3B'].to_i
          season.home_runs          = row['HR'].to_i
          season.rbis               = row['RBI'].to_i
          season.stolen_bases       = row['SB'].to_i
          season.caught_stealing    = row['CS'].to_i

        end
      end
    end

    puts 'Import complete.'
  end

  desc 'Import all player data'
  task :all => [:players, :stats]

end
