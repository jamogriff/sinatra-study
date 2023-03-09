def date_valid?(date)
  date =~ /\A\d{1,2}[-]\d{1,2}[-]\d{4}\z/
end

def number_valid?(number)
  number =~ /\A\d+\z/
end

