# frozen_string_literal: true

require 'rails_helper'

describe 'admin accesses the vehicle edit screen' do
  it 'from details page' do
    create(:transporter)
    user = create(:user)
    attr = build(:vehicle)
    vehicle = create(:vehicle, user: user)

    sign_in user
    visit vehicle_path(vehicle.id)
    click_on 'Editar veículo'
    fill_in 'Placa de identificação:', with: attr.license_plate
    fill_in 'Capacidade:', with: attr.capacity
    click_on 'Atualizar Veículo'

    expect(page).to have_current_path vehicle_path(vehicle.id)
    expect(page).to have_content 'Veículo atualizada com sucesso!'
    expect(page).not_to have_content vehicle.license_plate
    expect(page).to have_content attr.license_plate
    expect(page).to have_content attr.capacity
    expect(page).to have_content vehicle.brand_name
    expect(page).to have_content vehicle.model
    expect(page).to have_content vehicle.year
  end

  it 'with invalid attributes' do
    create(:transporter)
    user = create(:user)
    vehicle = create(:vehicle, user: user)

    sign_in user
    visit vehicle_path(vehicle.id)
    click_on 'Editar veículo'
    fill_in 'Placa de identificação:', with: ''
    fill_in 'Capacidade:', with: ''
    click_on 'Atualizar Veículo'

    expect(page).to have_content 'Atualizar Veículo'
    expect(page).to have_content 'Verifique os erros abaixo:'
    expect(page).to have_content 'Não foi possivel atualizar a veículo.'
    expect(page).to have_content 'Placa de identificação não pode ficar em branco'
    expect(page).to have_content 'Placa de identificação deve ter o formato: AAA0A00'
    expect(page).to have_content 'Capacidade não pode ficar em branco'
    expect(page).to have_link 'Voltar'
  end
end
