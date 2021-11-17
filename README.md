# Instructions for running the application locally

Use this command for cloning the repo:
* git clone https://github.com/danipele/impero_weather.git

Open ./impero_weather directory and run the following commands:
* bundle install
* yarn install
* bundle exec rake db:create db:migrate db:seed RAILS_ENV=development

Run the application locally using the following commands (the application will run on port 4110):
* source .env.local
* rails s
