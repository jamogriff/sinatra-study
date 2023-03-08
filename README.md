# Calorie Tracker

A bare-bones calorie tracker API built with Ruby, [Sinatra](http://sinatrarb.com/intro.html), Sequel and Sqlite

## Rake tasks
`rake db:create` to create database (assumes there's a `CalorieTracker.db` file created under `database/`)
`rake make:user` CLI program to create a user

## API Endpoints
`get` /api/v1/user/{user_id}/calories - requires `date` query param sent in d-m-yyyy format
`post` /api/v1/user/{user_id}/calories - requires `date` query param sent in d-m-yyyy format and a number `amount` param
