reset_db:
	RACK_ENV=test rake db:reset
	RACK_ENV=test rake db:migrate

test_models:
	RACK_ENV=test rake test:models

test_app:
	RACK_ENV=test rake test:app

test: reset_db test_models test_app

import:
	RACK_ENV=development rake db:reset
	RACK_ENV=development rake db:migrate
	RACK_ENV=development rake import:all

run_server:
	ruby app.rb

run_demo: test import run_server
