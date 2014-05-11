ENV['RACK_ENV'] = 'test'

require_relative 'app'
require 'test/unit'
require 'rack/test'

class OnLifeTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get '/'
    assert last_response.ok?
  end

end
