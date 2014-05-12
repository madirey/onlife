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
        Player.where(:player_id => player_id).first_or_create do |p|
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
      player_id = row['playerID']
      if player_id
        PlayerYear.where(:player_id => player_id).first_or_create do |stats|
          stats.year = row['year']
          stats.league = row['league']
          stats.team = row['teamID']
          stats.games = row['G']
          stats.at_bats = row['AB']
          stats.runs = row['R']
          stats.hits = row['H']
          stats.doubles = row['2B']
          stats.triples = row['3B']
          stats.home_runs = row['HR']
          stats.rbis = row['RBI']
          stats.stolen_bases = row['SB']
          stats.caught_stealing = row['CS']
        end
      end
    end

    puts 'Import complete.'
  end

  desc 'Import all player data'
  task :all => [:players, :stats]

end
