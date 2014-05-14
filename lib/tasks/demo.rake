# Rake tasks for OnLife demo/assignment

namespace :demo do

  desc "Most improved batting average from 2009 to 2010, assuming 200 at-bats"
  task :batting_average do

    stats_2009   = {}
    stats_2010   = {}
    stats_deltas = {}

    puts "\nMost improved batting average from 2009 to 2010 (>=200 at-bats):"

    # NOTE: Not a great approach performance-wise, but ultimately gotta
    # finish this thing.

    # ALSO: This does not account for players who may have switched teams
    # mid-year (their latest record will overwrite the others). FIXME

    Season.where(year: 2009).where('at_bats > ?', 199).each do |stats|
      stats_2009[stats.player_id] = stats.batting_average
    end

    Season.where(year: 2010).where('at_bats > ?', 199).each do |stats|
      stats_2010[stats.player_id] = stats.batting_average
    end

    # Calculate deltas
    stats_2010.each do |player_id, avg_2010|
      if stats_2009.has_key?(player_id)
        stats_deltas[player_id] = avg_2010 - stats_2009[player_id]
      end
    end

    # Find the maximum delta and corresponding key(s)
    max_delta = stats_deltas.values.max
    most_improved_players = stats_deltas.select{|k,v| v == max_delta}.keys

    most_improved_players.each do |player_id|
      player = Player.find(player_id)
      puts "#{player.full_name} with an improvement of #{max_delta}"
    end

  end

  desc "Slugging percentages for Oakland A's team in 2007"
  task :slugging_percentage do

    puts "\nSlugging percentage for all players on the Oakland A's in 2007:"

    Season.where(year: 2007, league: 'AL', team: 'OAK').each do |stats|
      puts "#{stats.player.full_name.ljust(20)}: #{stats.slugging_percentage}"
    end

  end

  desc "Triple crown winners for 2011 and 2012"
  task :triple_crown do

    puts "\nTriple crown winners for 2011 and 2012 (>=400 at-bats):"

    # For each season and each year, check to see if the homerun leader is also the
    # RBI leader. If not, we don't bother to calculate the batting average. We could
    # have also addressed this by computing a calculated 'batting_average' field upon
    # saving of the Season records, but that is not the approach we took in the end.
    [2011, 2012].each do |year|
      ['AL', 'NL'].each do |league|

        players = Season.where(year: year, league: league).where('at_bats > ?', 399)
        homerun_leader = players.order(home_runs: :desc).first
        rbi_leader     = players.order(rbis: :desc).first
        winner         = true

        if homerun_leader == rbi_leader
          # Homerun leader is also the RBI leader, so let's see if he is also the
          # batting average leader.
          players.each do |player|

            if player.batting_average > homerun_leader.batting_average
              # Somebody did better than this guy... let's move on.
              winner = false
              break
            end
          end

        else
          winner = false
        end

        # If we made it here without the winner being "refuted," then
        # we found ourselves a triple crown winner.
        if winner
          puts "#{year} #{league}: #{homerun_leader.player.full_name}"
        else
          puts "#{year} #{league}: Nobody"
        end

      end
    end

  end

  desc "Run the entire demo"
  task :all => [:batting_average, :slugging_percentage, :triple_crown]

end
