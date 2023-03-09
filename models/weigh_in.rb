require 'sequel'

class WeighIn < Sequel::Model
  plugin :validation_helpers
  many_to_one :user

  def validate
    super
    validates_presence [:weight, :date]
    validates_integer :weight
  end

end
