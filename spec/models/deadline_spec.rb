# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Deadline, type: :model do
  describe 'are there validations?' do
    context 'with association' do
      it { is_expected.to belong_to(:transporter) }
    end

    context 'with presence' do
      it { is_expected.to validate_presence_of(:max_distance) }
      it { is_expected.to validate_presence_of(:min_distance) }
      it { is_expected.to validate_presence_of(:period) }
    end
  end
end
