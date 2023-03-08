require './models/calorie_intake'
require './models/user'

get '/api/v1/user/:id/calories' do
  binding.pry
  user = User[:id]
  if !user.nil?
    if date_valid?(params['date'])
      date = Date.strptime(params['date'], '%d-%m-%Y')
      user_calories = DB[:calorie_intakes].select(:calories).where(user_id: user.id).where(date: date).all
      # TODO there's the sum enum for the following
      total_calories = 0
      user_calories.each { |uc| total_calories += uc.fetch(:calories) }
      { calories_consumed: total_calories }.to_json
    else
      { error: 'A date query param in m-d-yyyy format must be sent to this endpoint'}.to_json
    end
  else
    { message: 'No user found'}.to_json
  end
end

post '/api/v1/user/:id/calories' do
  user = User[:id]
  if !user.nil?
    if date_valid?(params['date']) and params['amount'] =~ /\A\d+\z/
      intake = CalorieIntake.new
      intake.calories = params['amount']
      binding.pry
      intake.date = Date.strptime(params['date'], '%d-%m-%Y')
      intake.user = user
      if intake.valid?
        intake.save
        { calorie_intake: intake.id,
          message: 'Calorie intake successfully saved' }.to_json
      else
        intake.errors.to_json
      end
    else
      { message: 'A date param must be passed in m-d-yyyy format alongside a numerical amount param'}.to_json
    end
  else
    { message: 'No user found'}.to_json
  end
end

def date_valid?(date)
  date =~ /\A\d{1,2}[-]\d{1,2}[-]\d{4}\z/
end
