# frozen_string_literal: true

class Budget < ApplicationRecord
  belongs_to :transporter

  validates :max_size,
            :min_size,
            :max_weight,
            :min_weight,
            :price, presence: true
end
