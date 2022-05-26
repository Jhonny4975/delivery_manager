# frozen_string_literal: true

require 'rails_helper'

describe 'the administrator accesses the transporters listing screen' do
  it 'and see all transporters' do
    first_transporter = create(:transporter)
    second_transporter = create(:transporter)

    sign_in create(:user, admin: true)
    visit user_root_path
    click_on 'Transportadoras'

    expect(page).to have_content 'Transportadoras'
    expect(page).to have_content first_transporter.brand_name
    expect(page).to have_content first_transporter.domain
    expect(page).to have_content first_transporter.registration_number
    expect(page).to have_content second_transporter.brand_name
    expect(page).to have_content second_transporter.domain
    expect(page).to have_content second_transporter.registration_number
  end

  it 'and see a message' do
    sign_in create(:user, admin: true)
    visit user_root_path
    click_on 'Transportadoras'

    expect(page).to have_content 'Transportadoras'
    expect(page).to have_content 'Não existem transportadoras cadastradas.'
  end
end
