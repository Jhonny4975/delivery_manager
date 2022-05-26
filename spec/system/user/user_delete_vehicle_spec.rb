# frozen_string_literal: true

require 'rails_helper'

describe 'User delete a vehicle' do
  it 'with sucess' do
    create(:transporter)
    vehicle = create(:vehicle)

    sign_in create(:user)
    visit vehicle_path(vehicle.id)
    click_on 'Deletar veículo'

    expect(page).to have_current_path vehicles_path
    expect(page).to have_content 'Não existem veículos cadastrados.'
    expect(page).not_to have_content vehicle.license_plate
  end

  it 'without deleting other vehicles' do
    create(:transporter)
    user = create(:user)
    one_vehicle = create(:vehicle, user: user)
    two_vehicle = create(:vehicle, user: user)

    sign_in user
    visit vehicle_path(two_vehicle.id)
    click_on 'Deletar veículo'

    expect(page).to have_current_path vehicles_path
    expect(page).to have_content 'Veículo excluído com sucesso!'
    expect(page).to have_content one_vehicle.model
  end
end
