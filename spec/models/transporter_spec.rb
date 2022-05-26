# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transporter, type: :model do
  describe 'are there validations?' do
    context 'with association' do
      it { is_expected.to have_many(:user).dependent(:destroy) }
      it { is_expected.to have_many(:budget).dependent(:destroy) }
    end

    context 'with presence' do
      it { is_expected.to validate_presence_of(:corporate_name) }
      it { is_expected.to validate_presence_of(:brand_name) }
      it { is_expected.to validate_presence_of(:registration_number) }
      it { is_expected.to validate_presence_of(:domain) }
      it { is_expected.to validate_presence_of(:full_address) }
    end

    context 'with uniqueness' do
      subject { build(:transporter) }

      it { is_expected.to validate_uniqueness_of(:corporate_name) }
      it { is_expected.to validate_uniqueness_of(:brand_name) }
      it { is_expected.to validate_uniqueness_of(:domain) }
      it { is_expected.to validate_uniqueness_of(:full_address) }
      it { is_expected.to validate_uniqueness_of(:registration_number).case_insensitive }
    end
  end

  describe '#valid?' do
    context 'with presence' do
      it 'invalid when corporate_name is not present' do
        transporter = described_class.new(attributes_for(:transporter, corporate_name: ''))

        expect(transporter).not_to be_valid
        expect(transporter.errors.full_messages.length).to eq 1
        expect(transporter.errors.full_messages.last).to eq 'Razão Social não pode ficar em branco'
      end

      it 'invalid when brand_name is not present' do
        transporter = described_class.new(attributes_for(:transporter, brand_name: ''))

        expect(transporter).not_to be_valid
        expect(transporter.errors.full_messages.length).to eq 1
        expect(transporter.errors.full_messages.first).to eq 'Nome Fantasia não pode ficar em branco'
      end

      it 'invalid when registration_number is not present' do
        transporter = create(:transporter)

        transporter.update(registration_number: '')

        expect(transporter).not_to be_valid
        expect(transporter.errors.full_messages.length).to eq 2
        expect(transporter.errors.full_messages.first).to eq 'CNPJ não pode ficar em branco'
        expect(transporter.errors.full_messages.last).to eq 'CNPJ deve ter o formato: 00.000.000/0000-00'
      end

      it 'invalid when domain is not present' do
        transporter = create(:transporter)

        transporter.update(domain: '')

        expect(transporter).not_to be_valid
        expect(transporter.errors.full_messages.length).to eq 1
        expect(transporter.errors.full_messages.first).to eq 'Domínio não pode ficar em branco'
      end

      it 'invalid when full_address is not present' do
        transporter = described_class.new(attributes_for(:transporter, full_address: ''))

        expect(transporter).not_to be_valid
        expect(transporter.errors.full_messages.length).to eq 1
        expect(transporter.errors.full_messages.first).to eq 'Endereço não pode ficar em branco'
      end
    end

    context 'with uniqueness' do
      it 'invalid when corporate_name is already in use' do
        first_transporter = create(:transporter)
        second_transporter = create(:transporter)

        second_transporter.update(corporate_name: first_transporter.corporate_name)

        expect(second_transporter).not_to be_valid
        expect(second_transporter.errors.full_messages.length).to eq 1
        expect(second_transporter.errors.full_messages.last).to eq 'Razão Social já está em uso'
      end

      it 'invalid when brand_name is already in use' do
        first_transporter = create(:transporter)
        second_transporter = described_class.new(attributes_for(:transporter, brand_name: first_transporter.brand_name))

        expect(second_transporter).not_to be_valid
        expect(second_transporter.errors.full_messages.length).to eq 1
        expect(second_transporter.errors.full_messages.last).to eq 'Nome Fantasia já está em uso'
      end

      it 'invalid when registration_number is already in use' do
        first_transporter = create(:transporter)

        second_transporter =
          described_class.new(attributes_for(:transporter, registration_number: first_transporter.registration_number))

        expect(second_transporter).not_to be_valid
        expect(second_transporter.errors.full_messages.length).to eq 1
        expect(second_transporter.errors.full_messages.last).to eq 'CNPJ já está em uso'
      end

      it 'invalid when domain is already in use' do
        first_transporter = create(:transporter)
        second_transporter = create(:transporter)

        second_transporter.update(domain: first_transporter.domain)

        expect(second_transporter).not_to be_valid
        expect(second_transporter.errors.full_messages.length).to eq 1
        expect(second_transporter.errors.full_messages.last).to eq 'Domínio já está em uso'
      end

      it 'invalid when full_address is already in use' do
        first_transporter = create(:transporter)
        second_transporter = described_class.new(attributes_for(:transporter, full_address: first_transporter.full_address))

        expect(second_transporter).not_to be_valid
        expect(second_transporter.errors.full_messages.length).to eq 1
        expect(second_transporter.errors.full_messages.last).to eq 'Endereço já está em uso'
      end
    end

    context 'with format validation' do
      it 'valid when registration_number matches format' do
        transporter = described_class.new(
          attributes_for(
            :transporter,
            registration_number: Faker::Company.brazilian_company_number(formatted: true)
          )
        )

        expect(transporter).to be_valid
        expect(transporter.errors).to be_empty
      end

      it 'invalid when registration_number does not match format' do
        transporter = create(:transporter)

        transporter.update(registration_number: '0000000000')

        expect(transporter).not_to be_valid
        expect(transporter.errors.full_messages.length).to eq 1
        expect(transporter.errors.full_messages.last).to eq 'CNPJ deve ter o formato: 00.000.000/0000-00'
      end
    end
  end

  describe '#associated?' do
    it 'get a user automatically' do
      transporter = create(:transporter, domain: 'test.com')
      user = create(:user, email: 'test@test.com')

      expect(transporter.user.first).to eq user
    end

    it 'has many users' do
      transporter = create(:transporter, domain: 'test.com')
      one_user = create(:user, email: 'test@test.com')
      two_user = create(:user, email: 'test2@test.com')

      expect(transporter.user.first).to eq one_user
      expect(transporter.user.last).to eq two_user
    end
  end
end
