require 'csv'

namespace :csv do
  desc 'Import player demographic data through 2012'
  task :import_players do |t|
    # Note that this will update players with new data, if run multiple times.
    # BUT it will NOT delete outdated records.
    CSV.foreach('data/Master-small.csv', :headers => true,
                                         :encoding => 'iso-8859-1:UTF-8') do |row|
      player_id = row['playerID']
      if player_id
        puts player_id
        p = Player.where(:player_id => player_id).first_or_create do |p|
          p.birth_year = row['birthYear']
          p.first_name = row['nameFirst']
          p.last_name = row['nameLast']
        end
      end
    end
  end

  desc 'Import player statistics from 2007-2012'
  task :import_stats do |t|
    # Note that this will update existing players' statistics, if run more than once.
    # BUT again, it will not delete outdated records that no longer appear in the CSV.
    CSV.foreach('data/Batting-07-12.csv', :headers => true,
                                          :encoding => 'iso-8859-1:UTF-8') do |row|
      
    end
  end

  desc 'Import all player data'
  task :import => [:import_players, :import_stats]

end
