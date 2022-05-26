# frozen_string_literal: true

FactoryBot.define do
  factory :budget do
    max_size { Faker::Number.decimal(l_digits: 2) }
    min_size { Faker::Number.decimal(l_digits: 2) }
    max_weight { Faker::Number.decimal(l_digits: 2) }
    min_weight { Faker::Number.decimal(l_digits: 2) }
    price { Faker::Number.decimal(l_digits: 2) }
    transporter
  end
end
