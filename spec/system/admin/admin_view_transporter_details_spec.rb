# frozen_string_literal: true

require 'rails_helper'

describe 'Admin view transporter details' do
  it 'Must see additional information' do
    transporter = create(:transporter)

    sign_in create(:user, admin: true)
    visit transporters_path
    click_on transporter.brand_name

    expect(page).to have_content "Transportadora: #{transporter.brand_name}"
    expect(page).to have_content "Razão Social: #{transporter.corporate_name}"
    expect(page).to have_content "CNPJ: #{transporter.registration_number}"
    expect(page).to have_content "Endereço: #{transporter.full_address}"
    expect(page).to have_content "Domínio: #{transporter.domain}"
    expect(page).to have_link 'Editar transportadora'
    expect(page).to have_link 'Voltar'
  end

  it 'and back to vehicles path' do
    transporter = create(:transporter)

    sign_in create(:user, admin: true)
    visit transporter_path(transporter.id)
    click_on 'Voltar'

    expect(page).to have_current_path transporters_path
  end
end
