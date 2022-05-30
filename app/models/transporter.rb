# frozen_string_literal: true

class Transporter < ApplicationRecord
  enum stats: { active: 0, inactive: 5 }

  has_many :user, dependent: :destroy
  has_many :budget, dependent: :destroy
  has_many :deadline, dependent: :destroy
  has_many :service_order, dependent: :destroy

  validates :corporate_name,
            :brand_name,
            :domain,
            :registration_number,
            :full_address, presence: true

  validates :corporate_name,
            :brand_name,
            :domain,
            :full_address, uniqueness: true

  validates :registration_number, uniqueness: { case_sensitive: false }

  validates :registration_number, format: { with: %r{\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}},
                                            message: 'deve ter o formato: 00.000.000/0000-00' }
end
