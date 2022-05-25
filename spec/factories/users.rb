# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { admin?(admin) }
    branch_office_name { Faker::Company.unique.name }
    phone_number { Faker::PhoneNumber.cell_phone }
    password { Faker::Internet.password }
    admin { false }
  end
end

def admin?(admin)
  return "#{Faker::Alphanumeric.alpha(number: 6)}@sistemadefrete.com.br" if admin == true

  "#{Faker::Alphanumeric.alpha(number: 6)}@#{set_transporter_domain}"
end

def set_transporter_domain
  Transporter.find_each { |transporter| return transporter.domain if transporter.user.empty? }

  Transporter.first&.domain
end
