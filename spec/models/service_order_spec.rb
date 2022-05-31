# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  describe 'are there validations?' do
    context 'with association' do
      it { is_expected.to belong_to(:transporter) }
    end

    context 'with presence' do
      it { is_expected.to validate_presence_of(:height) }
      it { is_expected.to validate_presence_of(:length) }
      it { is_expected.to validate_presence_of(:width) }
      it { is_expected.to validate_presence_of(:weight) }
      it { is_expected.to validate_presence_of(:distance) }
      it { is_expected.to validate_presence_of(:pickup_address) }
      it { is_expected.to validate_presence_of(:recipient_name) }
      it { is_expected.to validate_presence_of(:recipient_phone_number) }
      it { is_expected.to validate_presence_of(:recipient_document) }
      it { is_expected.to validate_presence_of(:delivery_address) }
      it { is_expected.to validate_presence_of(:sku) }
      it { is_expected.to define_enum_for(:stats) }
    end
  end

  describe '#valid?' do
    context 'with presence' do
      it 'invalid when attributes is not present' do
        service_order = build(
          :service_order,
          height: '',
          length: '',
          width: '',
          weight: '',
          distance: '',
          pickup_address: '',
          recipient_name: '',
          recipient_phone_number: '',
          recipient_document: '',
          delivery_address: '',
          sku: '',
          transporter_id: ''
        )

        expect(service_order).not_to be_valid
        expect(service_order.errors.full_messages.length).to eq 12
      end
    end

    context 'with uniqueness' do
      it 'invalid when code is already in use' do
        first_service_order = create(:service_order)
        second_service_order = create(:service_order)

        second_service_order.update(code: first_service_order.code)

        expect(second_service_order).not_to be_valid
        expect(second_service_order.errors.full_messages.length).to eq 1
        expect(second_service_order.errors.full_messages.last).to eq 'Code já está em uso'
      end
    end

    # criar testes de validação para formato dos campos.
  end
end
