# frozen_string_literal: true

require 'rails_helper'

describe 'Admin register a transporter' do
  it 'from index page' do
    visit transporters_path
    click_on 'Nova Transportadora'

    expect(page).to have_current_path new_transporter_path
    expect(page).to have_field 'Nome Fantasia:'
    expect(page).to have_field 'Razão Social:'
    expect(page).to have_field 'Domínio:'
    expect(page).to have_field 'CNPJ:'
    expect(page).to have_field 'Endereço:'
    expect(page).to have_button 'Criar Transportadora'
    expect(page).to have_link 'Voltar'
  end

  it 'with valid params' do
    attributes = build(:transporter)

    visit new_transporter_path
    fill_in 'Nome Fantasia:', with: attributes.corporate_name
    fill_in 'Razão Social:', with: attributes.brand_name
    fill_in 'Domínio:', with: attributes.domain
    fill_in 'CNPJ:', with: attributes.registration_number
    fill_in 'Endereço:', with: attributes.full_address
    click_on 'Criar Transportadora'

    expect(page).to have_current_path transporter_path(Transporter.last.id)
    expect(page).to have_content 'Transportadora cadastrada com sucesso!'
  end

  it 'with invalid params' do
    visit new_transporter_path
    fill_in 'Nome Fantasia:', with: ''
    fill_in 'Razão Social:', with: ''
    fill_in 'Domínio:', with: ''
    fill_in 'CNPJ:', with: ''
    fill_in 'Endereço:', with: ''
    click_on 'Criar Transportadora'

    expect(page).to have_current_path transporters_path
    expect(page).to have_content 'Transportadora não cadastrada.'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Domínio não pode ficar em branco'
    expect(page).to have_content 'CNPJ deve ter o formato: 00.000.000/0000-00'
  end
end
