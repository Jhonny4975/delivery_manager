# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'are there validations?' do
    context 'with association' do
      it { is_expected.to belong_to(:transporter).optional }
      it { is_expected.to have_many(:vehicle).dependent(:destroy) }
    end

    context 'with uniqueness' do
      subject { build(:user) }

      it { is_expected.to validate_uniqueness_of(:branch_office_name) }
    end
  end

  describe '#valid?' do
    context 'with presence' do
      it 'invalid when email is not present' do
        user = described_class.new(attributes_for(:user, email: ''))

        expect(user).not_to be_valid
        expect(user.errors.full_messages.length).to eq 2
        expect(user.errors.full_messages.first).to eq 'E-mail não pode ficar em branco'
        expect(user.errors.full_messages.last).to eq 'E-mail não corresponde a nenhuma transportadora cadastrada.'
      end

      it 'invalid when password is not present' do
        create(:transporter)
        user = described_class.new(attributes_for(:user, password: ''))

        expect(user).not_to be_valid
        expect(user.errors.full_messages.length).to eq 1
        expect(user.errors.full_messages.first).to eq 'Senha não pode ficar em branco'
      end
    end

    context 'with uniqueness' do
      it 'invalid when branch_office_name is already in use' do
        create_list(:transporter, 2)
        first_user = create(:user)
        second_user = create(:user)

        second_user.update(branch_office_name: first_user.branch_office_name)

        expect(second_user).not_to be_valid
        expect(second_user.errors.full_messages.length).to eq 1
        expect(second_user.errors.full_messages.last).to eq 'Nome da filial já está em uso'
      end

      it 'invalid when email is already in use' do
        create_list(:transporter, 2)
        first_user = create(:user)
        second_user = described_class.new(attributes_for(:user, email: first_user.email))

        expect(second_user).not_to be_valid
        expect(second_user.errors.full_messages.length).to eq 1
        expect(second_user.errors.full_messages.last).to eq 'E-mail já está em uso'
      end
    end

    context 'with format validation' do
      it 'invalid when email does not match format' do
        create(:transporter)
        user = create(:user)

        user.update(email: 'example.um@test.com')

        expect(user).not_to be_valid
        expect(user.errors.full_messages.length).to eq 1
        expect(user.errors.full_messages.last).to eq 'E-mail não é válido'
      end
    end

    context 'with rules' do
      it 'invalid when there is no transporters' do
        user = described_class.new(attributes_for(:user))

        expect(user).not_to be_valid
        expect(user.errors.full_messages.length).to eq 2
        expect(user.errors.full_messages.first).to eq 'E-mail não é válido'
        expect(user.errors.full_messages.last).to eq 'E-mail não corresponde a nenhuma transportadora cadastrada.'
      end

      it 'does not belong to transporter when it is admin' do
        user = described_class.new(attributes_for(:user, admin: true))

        expect(user.transporter).to be_nil
        expect(user).to be_admin
      end
    end
  end

  describe '#associated?' do
    it 'belongs to transporter automatically' do
      transporter = create(:transporter, domain: 'test.com')
      user = create(:user, email: 'test@test.com')

      expect(user.transporter).to eq transporter
    end

    it 'has many vehicles' do
      create(:transporter)
      user = create(:user)
      one_vehicle = create(:vehicle, user: user)
      two_vehicle = create(:vehicle, user: user)

      expect(user.vehicle.first).to eq one_vehicle
      expect(user.vehicle.last).to eq two_vehicle
    end
  end
end
