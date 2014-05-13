# Rake tasks for OnLife demo/assignment

namespace :demo do

  desc "Most improved batting average from 2009 to 2010, assuming 200 at-bats"
  task :batting_average do
    Player.where(year: 2009).each do |stats|
      puts stats.hits
    end
  end

  desc "Slugging percentages for Oakland A's team in 2007"
  task :slugging_percentage do

  end

  desc "Triple crown winners for 2011 and 2012"
  task :triple_crown do

  end

  desc "Run the entire demo"
  task :all => [:batting_average, :slugging_percentage, :triple_crown]

end
