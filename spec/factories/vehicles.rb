# frozen_string_literal: true

FactoryBot.define do
  factory :vehicle do
    license_plate { license_plate_generator }
    brand_name { Faker::Vehicle.manufacture }
    model { Faker::Vehicle.model }
    year { Faker::Vehicle.year }
    capacity { Faker::Number.number(digits: 2) }
  end
end

def license_plate_generator
  "#{Faker::Alphanumeric.alpha(number: 3).upcase}0A#{Faker::Number.number(digits: 2)}"
end
