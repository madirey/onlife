# Rake tasks for OnLife demo/assignment

namespace :demo do

  desc "Most improved batting average from 2009 to 2010, assuming 200 at-bats"
  task :batting_average do

    stats_2009   = {}
    stats_2010   = {}
    stats_deltas = {}

    puts 'Most improved batting average from 2009 to 2010 (>200 at-bats)'

    # NOTE: Not a great approach performance-wise, but ultimately gotta
    # finish this thing.

    # ALSO: This does not account for players who may have switched teams
    # mid-year (their latest record will overwrite the others). FIXME

    Season.where(year: 2009).where('at_bats > ?', 200).each do |stats|
      stats_2009[stats.player_id] = stats.batting_average
    end

    Season.where(year: 2010).where('at_bats > ?', 200).each do |stats|
      stats_2010[stats.player_id] = stats.batting_average
    end

    stats_2010.each do |player_id|
      if stats_2009.has_key?(player_id)
        stats_deltas[player_id] = stats_2010[player_id] - stats_2009[player_id]
      end
    end

    max_delta = stats_deltas.values.max
    most_improved_players = stats_deltas.select{|k,v| v == max_delta}.keys

    most_improved_players.each do |player_id|
      puts "#{player_id} with an improvement of #{max_delta}"
    end

  end

  desc "Slugging percentages for Oakland A's team in 2007"
  task :slugging_percentage do

    puts "Slugging percentage for all players on the Oakland A's in 2007"

    Season.where(year: 2007, league: 'AL', team: 'OAK').each do |stats|
      puts "#{stats.player.full_name}: #{stats.slugging_percentage}"
    end

  end

  desc "Triple crown winners for 2011 and 2012"
  task :triple_crown do

  end

  desc "Run the entire demo"
  task :all => [:batting_average, :slugging_percentage, :triple_crown]

end
