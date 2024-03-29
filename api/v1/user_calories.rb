require './models/calorie_intake'
require './models/user'
require './helpers/validations'

get '/api/v1/user/:id/calories' do
  user = User[params['id']]
  return no_user_response unless !user.nil?
  return invalid_date_response unless date_valid?(params['date'])

  date = get_formatted_date(params['date'])
  user_calories = DB[:calorie_intakes].select(:calories).where(user_id: user.id).where(date: date).all
  # TODO there's the sum enum for the following
  total_calories = 0
  user_calories.each { |uc| total_calories += uc.fetch(:calories) }
  { calories_consumed: total_calories }.to_json
end

post '/api/v1/user/:id/calories' do
  user = User[params['id']]
  return no_user_response unless !user.nil?
  return invalid_date_response unless date_valid?(params['date'])
  return invalid_calorie_response unless number_valid?(params['amount'])

  intake = CalorieIntake.new
  intake.calories = params['amount']
  intake.date = get_formatted_date(params['date'])
  intake.user = user
  if intake.valid?
    intake.save
    { calorie_intake: intake.id,
      message: 'Calorie intake successfully saved' }.to_json
  else
    intake.errors.to_json
  end
end

def get_formatted_date(string)
  Date.strptime(params['date'], '%m-%d-%Y')
end

def invalid_date_response
  { error: 'A date query param in m-d-yyyy format must be sent to this endpoint'}.to_json
end

def no_user_response
  { error: 'No user found'}.to_json
end

def invalid_calorie_response
  { error: 'A numerical amount query param must be sent to this endpoint'}.to_json
end
