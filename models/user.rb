require 'sequel'

class User < Sequel::Model
  plugin :validation_helpers
  one_to_many :calorie_intakes

  def validate
    super
    validates_presence [:first_name, :email]
    validates_max_length 80, [:first_name, :email]
    validates_unique :email
    # TODO this format doesn't allow periods in email address
    validates_format URI::MailTo::EMAIL_REGEXP, :email, message: 'is not a valid email address'
  end

end
