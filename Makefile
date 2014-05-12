reset_db:
	RACK_ENV=test rake db:reset
	RACK_ENV=test rake db:migrate

test: reset_db
	RACK_ENV=test rake test:all
