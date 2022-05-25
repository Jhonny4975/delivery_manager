# frozen_string_literal: true

require 'rails_helper'

describe 'Admin view vehicle details' do
  it 'Must see additional information' do
    create(:transporter)
    user = create(:user)
    vehicle = create(:vehicle, user: user)

    sign_in user
    visit vehicles_path
    click_on vehicle.model

    expect(page).to have_content "Veículo: #{vehicle.license_plate}"
    expect(page).to have_content "Marca: #{vehicle.brand_name}"
    expect(page).to have_content "Modelo: #{vehicle.model}"
    expect(page).to have_content "Ano: #{vehicle.year}"
    expect(page).to have_content "Capacidade: #{vehicle.capacity} kg"
    expect(page).to have_link 'Voltar'
  end
end
