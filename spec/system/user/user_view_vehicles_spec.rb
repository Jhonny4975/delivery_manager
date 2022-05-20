# frozen_string_literal: true

require 'rails_helper'

describe 'the user accesses the vehicles listing screen' do
  it 'and see all vehicles' do
    vehicles = create_list(:vehicle, 2)

    visit vehicles_path

    expect(page).to have_content 'Veículos'
    expect(page).to have_link vehicles.first.model
    expect(page).to have_content "#{vehicles.first.capacity} kg"
    expect(page).to have_link vehicles.last.model
    expect(page).to have_content "#{vehicles.last.capacity} kg"
    expect(page).not_to have_content 'Não existem veículos cadastrados.'
  end

  it 'and see a message' do
    visit vehicles_path

    expect(page).to have_content 'Não existem veículos cadastrados.'
  end
end
