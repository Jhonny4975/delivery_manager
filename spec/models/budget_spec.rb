# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Budget, type: :model do
  describe 'are there validations?' do
    context 'with association' do
      it { is_expected.to belong_to(:transporter) }
    end

    context 'with presence' do
      it { is_expected.to validate_presence_of(:max_size) }
      it { is_expected.to validate_presence_of(:min_size) }
      it { is_expected.to validate_presence_of(:max_weight) }
      it { is_expected.to validate_presence_of(:min_weight) }
      it { is_expected.to validate_presence_of(:price) }
    end
  end
end
