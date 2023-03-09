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

  # NOTE for zsh the brackets need to be escaped
  desc 'Adds weigh-in on current date'
  task :weigh_in, [:user, :weight] do | t, args |
    require './database/connection.rb'
    require './models/user.rb'
    require './models/weigh_in.rb'
    require './helpers/validations.rb'
    require 'date'
    user = User[args[:user]]
    return 'No user found' unless !user.nil?

    weigh_in = WeighIn.new
    is_weight_logged = false
    while !is_weight_logged do
      weigh_in.date = Date.today
      weigh_in.weight = args[:weight]
      weigh_in.user = user

      if weigh_in.valid?
        weigh_in.save
        is_weight_logged = true
        puts "Weigh-in successfully created with an ID of #{weigh_in.id}. Go you!"
      else
        puts "Failed to save weigh-in:\n"
        # TODO need to pull out strings here
        puts weigh_in.errors
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

  # TODO should eventually add migrations
  desc 'Adds weigh-in table & changes calories to Int'
  task :migrate do
    require 'sequel'
    require './database/connection.rb'

    DB.create_table :weigh_ins do
      primary_key :id
      foreign_key :user_id, :users
      Integer :weight
      Date :date
    end

    DB.alter_table :calorie_intakes do
       set_column_type :calories, :Integer
    end

    puts 'Database altered'
  end
end
