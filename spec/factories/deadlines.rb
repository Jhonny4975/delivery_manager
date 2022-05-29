# frozen_string_literal: true

FactoryBot.define do
  factory :deadline do
    max_distance { Faker::Number.number(digits: 3) }
    min_distance { Faker::Number.number(digits: 2) }
    period { Faker::Number.non_zero_digit }
    transporter
  end
end
