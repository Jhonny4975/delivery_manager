# frozen_string_literal: true

class ServiceOrder < ApplicationRecord
  enum stats: {
    pending: 0,
    accepted: 5,
    refused: 10,
    collected: 15,
    in_transit: 20,
    finished: 25
  }

  belongs_to :transporter

  validates :height,
            :length,
            :width,
            :weight,
            :distance,
            :pickup_address,
            :recipient_name,
            :recipient_phone_number,
            :recipient_document,
            :delivery_address,
            :sku,
            :stats, presence: true

  validates :code, uniqueness: true

  after_validation :generate_code, on: :create

  private

  def generate_code
    self.code = SecureRandom.hex(15)
  end
end
