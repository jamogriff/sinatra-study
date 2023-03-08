require 'sequel'

class CalorieIntake < Sequel::Model
  plugin :validation_helpers
  many_to_one :user

  def validate
    super
    validates_presence [:calories, :date]
    validates_numeric :calories
  end

end
