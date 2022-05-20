# frozen_string_literal: true

class Vehicle < ApplicationRecord
  validates :license_plate,
            :brand_name,
            :model,
            :capacity, presence: true

  validates :license_plate, uniqueness: true

  validates :license_plate, format: { with: /\A[A-Z]{3}\d[A-Z]\d{2}\z/,
                                      message: 'deve ter o formato: AAA0A00' }
end
