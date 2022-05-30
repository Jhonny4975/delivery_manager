# frozen_string_literal: true

FactoryBot.define do
  factory :service_order do
    recipient_name { Faker::FunnyName.name }
    recipient_phone_number { Faker::PhoneNumber.cell_phone }
    recipient_document { Faker::IDNumber.brazilian_citizen_number(formatted: true) }
    pickup_address { Faker::Address.full_address }
    delivery_address { Faker::Address.full_address }
    height { Faker::Number.within(range: 1..3) }
    length { Faker::Number.within(range: 1..2) }
    width { Faker::Number.within(range: 0.5..1) }
    weight { Faker::Number.within(range: 1..50) }
    distance { Faker::Number.within(range: 50..100) }
    sku { Faker::Alphanumeric.alpha(number: 10) }
    stats { 0 }
    transporter
  end
end
