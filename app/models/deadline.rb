# frozen_string_literal: true

class Deadline < ApplicationRecord
  belongs_to :transporter

  validates :max_distance,
            :min_distance,
            :period, presence: true
end
