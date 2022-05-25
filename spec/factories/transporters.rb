# frozen_string_literal: true

FactoryBot.define do
  factory :transporter do
    corporate_name { Faker::Company.name }
    brand_name { Faker::Company.unique.industry }
    domain { set_domain }
    registration_number { Faker::Company.brazilian_company_number(formatted: true) }
    full_address { Faker::Address.full_address }
  end
end

def set_domain
  "#{Faker::Alphanumeric.alpha(number: 3)}#{Faker::Internet.free_email.match(/@/).post_match}"
end
