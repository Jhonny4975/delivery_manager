# frozen_string_literal: true

class ServiceOrder < ApplicationRecord
  enum stats: { pending: 0, passed: 5, failed: 10 }

  belongs_to :transporter

  after_validation :generate_code, on: :create

  private

  def generate_code
    self.code = SecureRandom.hex(15)
  end
end
