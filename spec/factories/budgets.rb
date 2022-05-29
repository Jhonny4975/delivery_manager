# frozen_string_literal: true

FactoryBot.define do
  factory :budget do
    max_size { Faker::Number.decimal(l_digits: 2, r_digits: 1) }
    min_size { Faker::Number.decimal(l_digits: 1, r_digits: 1) }
    max_weight { Faker::Number.decimal(l_digits: 2, r_digits: 1) }
    min_weight { Faker::Number.decimal(l_digits: 1, r_digits: 1) }
    price { Faker::Number.decimal(l_digits: 1) }
    transporter
  end
end
