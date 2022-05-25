# frozen_string_literal: true

require 'rails_helper'

describe 'the user accesses the vehicles listing screen' do
  it 'and see all vehicles' do
    create(:transporter)
    user = create(:user)
    one_vehicle = create(:vehicle, user: user)
    two_vehicle = create(:vehicle, user: user)

    sign_in user
    visit vehicles_path

    expect(page).to have_content 'Veículos'
    expect(page).to have_link one_vehicle.model
    expect(page).to have_content "#{one_vehicle.capacity} kg"
    expect(page).to have_link two_vehicle.model
    expect(page).to have_content "#{two_vehicle.capacity} kg"
    expect(page).not_to have_content 'Não existem veículos cadastrados.'
  end

  it 'and see a message' do
    create(:transporter)
    user = create(:user)

    sign_in user
    visit vehicles_path

    expect(page).to have_content 'Não existem veículos cadastrados.'
  end
end
