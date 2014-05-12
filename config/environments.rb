# Adapted from: https://gist.github.com/hatboysam/4155937/raw/environments.rb

configure :production do
  db = URI.parse(ENV['PG_URL'] || 'postgres://localhost/onlife')

  ActiveRecord::Base.establish_connection(
    :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end
