# frozen_string_literal: true

require 'rails_helper'

describe 'the administrator accesses the transporters listing screen' do
  it 'and see all transporters' do
    sign_in create(:user, admin: true)
    create(:transporter)
    create(:transporter)

    visit transporters_path

    expect(page).to have_content 'Transportadoras'
    expect(page).to have_content Transporter.first.brand_name
    expect(page).to have_content Transporter.first.domain
    expect(page).to have_content Transporter.first.registration_number
    expect(page).to have_content Transporter.last.brand_name
    expect(page).to have_content Transporter.last.domain
    expect(page).to have_content Transporter.last.registration_number
  end

  it 'and see a message' do
    sign_in create(:user, admin: true)
    visit transporters_path

    expect(page).to have_content 'Transportadoras'
    expect(page).to have_content 'Não existem transportadoras cadastradas.'
  end
end
