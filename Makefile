reset_db:
	bundle exec "RACK_ENV=test rake db:drop"
	bundle exec "RACK_ENV=test rake db:migrate"

test_models:
	bundle exec "RACK_ENV=test rake test:models"

test_app:
	bundle exec "RACK_ENV=test rake test:app"

test: reset_db test_models test_app

import:
	bundle exec "RACK_ENV=development rake db:reset"
	bundle exec "RACK_ENV=development rake db:migrate"
	bundle exec "RACK_ENV=development rake import:all"

run_demo: import
	bundle exec "RACK_ENV=development rake demo:all"
