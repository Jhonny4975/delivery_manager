# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe 'are there validations?' do
    context 'with association' do
      it { is_expected.to belong_to(:user).optional }
    end

    context 'with presence' do
      it { is_expected.to validate_presence_of(:license_plate) }
      it { is_expected.to validate_presence_of(:brand_name) }
      it { is_expected.to validate_presence_of(:model) }
      it { is_expected.to validate_presence_of(:capacity) }
    end

    context 'with uniqueness' do
      subject { build(:vehicle) }

      it { is_expected.to validate_uniqueness_of(:license_plate) }
    end
  end

  describe '#valid?' do
    context 'with presence' do
      it 'invalid when license_plate is not present' do
        vehicle = described_class.new(attributes_for(:vehicle, license_plate: ''))

        expect(vehicle).not_to be_valid
        expect(vehicle.errors.full_messages.length).to eq 2
        expect(vehicle.errors.full_messages.first).to eq 'Placa de identificação não pode ficar em branco'
        expect(vehicle.errors.full_messages.last).to eq 'Placa de identificação deve ter o formato: AAA0A00'
      end

      it 'invalid when brand_name is not present' do
        vehicle = described_class.new(attributes_for(:vehicle, brand_name: ''))

        expect(vehicle).not_to be_valid
        expect(vehicle.errors.full_messages.length).to eq 1
        expect(vehicle.errors.full_messages.first).to eq 'Marca não pode ficar em branco'
      end

      it 'invalid when model is not present' do
        vehicle = create(:vehicle)

        vehicle.update(model: '')

        expect(vehicle).not_to be_valid
        expect(vehicle.errors.full_messages.length).to eq 1
        expect(vehicle.errors.full_messages.first).to eq 'Modelo não pode ficar em branco'
      end

      it 'invalid when capacity is not present' do
        vehicle = create(:vehicle)

        vehicle.update(capacity: '')

        expect(vehicle).not_to be_valid
        expect(vehicle.errors.full_messages.length).to eq 1
        expect(vehicle.errors.full_messages.first).to eq 'Capacidade não pode ficar em branco'
      end
    end

    context 'with uniqueness' do
      it 'invalid when license_plate is already in use' do
        first_vehicle = create(:vehicle)
        second_vehicle = create(:vehicle)

        second_vehicle.update(license_plate: first_vehicle.license_plate)

        expect(second_vehicle).not_to be_valid
        expect(second_vehicle.errors.full_messages.length).to eq 1
        expect(second_vehicle.errors.full_messages.last).to eq 'Placa de identificação já está em uso'
      end
    end

    context 'with format validation' do
      it 'valid when license_plate matches format' do
        vehicle = described_class.new(
          attributes_for(
            :vehicle,
            license_plate: "#{Faker::Alphanumeric.alpha(number: 3).upcase}0A#{Faker::Number.number(digits: 2)}"
          )
        )

        expect(vehicle).to be_valid
        expect(vehicle.errors).to be_empty
      end

      it 'invalid when license_plate does not match format' do
        vehicle = create(:vehicle)

        vehicle.update(license_plate: '000AWDA')

        expect(vehicle).not_to be_valid
        expect(vehicle.errors.full_messages.length).to eq 1
        expect(vehicle.errors.full_messages.last).to eq 'Placa de identificação deve ter o formato: AAA0A00'
      end
    end
  end

  describe '#associated?' do
    it 'belongs to user' do
      create(:transporter)
      user = create(:user)
      vehicle = create(:vehicle, user: user)

      expect(vehicle.user).to eq user
    end
  end
end
