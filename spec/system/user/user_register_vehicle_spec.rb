# frozen_string_literal: true

require 'rails_helper'

describe 'User register a vehicle' do
  it 'from index page' do
    create(:transporter)
    user = create(:user)

    sign_in user
    visit vehicles_path
    click_on 'Novo Veículo'

    expect(page).to have_current_path new_vehicle_path
    expect(page).to have_field 'Placa de identificação:'
    expect(page).to have_field 'Marca:'
    expect(page).to have_field 'Modelo:'
    expect(page).to have_field 'Ano:'
    expect(page).to have_field 'Capacidade:'
    expect(page).to have_button 'Criar Veículo'
    expect(page).to have_link 'Voltar'
  end

  it 'with valid params' do
    create(:transporter)
    user = create(:user)
    attributes = build(:vehicle)

    sign_in user
    visit new_vehicle_path
    fill_in 'Placa de identificação:', with: attributes.license_plate
    fill_in 'Marca:', with: attributes.brand_name
    fill_in 'Modelo:', with: attributes.model
    fill_in 'Ano:', with: attributes.year
    fill_in 'Capacidade:', with: attributes.capacity
    click_on 'Criar Veículo'

    expect(page).to have_current_path vehicle_path(Vehicle.last.id)
    expect(page).to have_content 'Veículo cadastrado com sucesso!'
  end

  it 'with invalid params' do
    create(:transporter)
    user = create(:user)

    sign_in user
    visit new_vehicle_path
    fill_in 'Placa de identificação:', with: ''
    fill_in 'Marca:', with: ''
    fill_in 'Modelo:', with: ''
    fill_in 'Capacidade:', with: ''
    click_on 'Criar Veículo'

    expect(page).to have_current_path vehicles_path
    expect(page).to have_content 'Veículo não cadastrado.'
    expect(page).to have_content 'Placa de identificação não pode ficar em branco'
    expect(page).to have_content 'Marca não pode ficar em branco'
    expect(page).to have_content 'Capacidade não pode ficar em branco'
    expect(page).to have_content 'Modelo não pode ficar em branco'
    expect(page).to have_content 'Placa de identificação deve ter o formato: AAA0A00'
  end
end
