# frozen_string_literal: true

require 'rails_helper'

describe 'User delete a vehicle' do
  it 'with sucess' do
    vehicle = create(:vehicle)

    visit vehicle_path(vehicle.id)
    click_on 'Deletar veículo'

    expect(page).to have_current_path vehicles_path
    expect(page).to have_content 'Não existem veículos cadastrados.'
    expect(page).not_to have_content vehicle.license_plate
  end

  it 'without deleting other vehicles' do
    first_vehicle = create(:vehicle)
    second_vehicle = create(:vehicle)

    visit vehicle_path(second_vehicle.id)
    click_on 'Deletar veículo'

    expect(page).to have_current_path vehicles_path
    expect(page).to have_content 'Veículo excluído com sucesso!'
    expect(page).to have_content first_vehicle.model
  end
end
