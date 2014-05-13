require 'csv'

namespace :import do
  desc 'Import player demographic data through 2012'
  task :players do |t|
    # Note that this will update players with new data, if run multiple times.
    # BUT it will NOT delete outdated records.
    puts 'Importing player demographic data...'

    CSV.foreach('data/Master-small.csv', :headers => true,
                                         :encoding => 'iso-8859-1:UTF-8') do |row|
      player_id = row['playerID']
      if player_id
        Player.where(:player_id => player_id).first_or_create! do |p|
          p.birth_year = row['birthYear']
          p.first_name = row['nameFirst']
          p.last_name = row['nameLast']
        end
      end
    end

    puts 'Import complete.'
  end

  desc 'Import player statistics from 2007-2012'
  task :stats do |t|
    # Note that this will update existing players' statistics, if run more than once.
    # BUT again, it will not delete outdated records that no longer appear in the CSV.
    puts 'Importing player statistical data...'

    CSV.foreach('data/Batting-07-12.csv', :headers => true,
                                          :encoding => 'iso-8859-1:UTF-8') do |row|

      # Below attributes represent a "unique" PlayerYear record
      player_id = row['playerID']
      year = row['yearID'].to_i
      league = row['league']
      team = row['teamID']

      # If we have enough data to identify a unique entry, then record it
      if player_id && year && league && team
        PlayerYear.where(:player_id => player_id,
                         :year => year,
                         :league => league,
                         :team => team).first_or_create! do |stats|

          # Gather player stats for this entry
          stats.games = row['G'].to_i
          stats.at_bats = row['AB'].to_i
          stats.runs = row['R'].to_i
          stats.hits = row['H'].to_i
          stats.doubles = row['2B'].to_i
          stats.triples = row['3B'].to_i
          stats.home_runs = row['HR'].to_i
          stats.rbis = row['RBI'].to_i
          stats.stolen_bases = row['SB'].to_i
          stats.caught_stealing = row['CS'].to_i

        end
      end
    end

    puts 'Import complete.'
  end

  desc 'Import all player data'
  task :all => [:players, :stats]

end
