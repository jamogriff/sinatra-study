require 'pry'

namespace :make do
  desc 'Creates a new user'
  task :user do
    require './database/connection.rb'
    require './models/user.rb'

    new_user = User.new
    is_user_created = false
    while !is_user_created do
      puts "First name:\n"
      new_user.first_name = STDIN.gets.chomp
      puts "Email address:\n"
      new_user.email = STDIN.gets.chomp

      if new_user.valid?
        new_user.save
        is_user_created = true
        puts "User successfully created with an ID of #{new_user.id}"
      else
        puts "Failed to create user:\n"
        # TODO need to pull out strings here
        puts new_user.errors
        puts "Try again or use Ctl + C to exit\n"
      end
    end
  end
end

namespace :db do
  desc 'Creates DB schema'
  task :create do
    require 'sequel'
    require './database/connection.rb'

    DB.create_table :users do
      primary_key :id
      String :first_name
      String :last_name
      String :email
    end

    # derp plurualize names
    DB.create_table :calorie_intakes do
      primary_key :id
      foreign_key :user_id, :users
      Numeric :calories
      Date :date
    end

    puts 'Database tables created'
  end
end
