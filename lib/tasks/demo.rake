# Rake tasks for OnLife demo/assignment

namespace :demo do

  desc 'Most improved batting average from 2009 to 2010'
  task :batting_average do
    Player.where(year: 2009).each do |stats|
      puts stats.hits
    end
  end

  desc 'Run the entire demo'
  task :all => [:batting_average]
end
