# frozen_string_literal: true

require 'rails_helper'

describe 'admin accesses the transporter edit screen' do
  it 'from details page' do
    sign_in create(:user, admin: true)
    attr = build(:transporter)
    transporter = create(:transporter)

    visit transporter_path(transporter.id)
    click_on 'Editar transportadora'
    fill_in 'Nome Fantasia:', with: attr.corporate_name
    fill_in 'Razão Social:', with: attr.brand_name
    click_on 'Atualizar Transportadora'

    expect(page).to have_current_path transporter_path(transporter.id)
    expect(page).to have_content 'Transportadora atualizada com sucesso!'
    expect(page).not_to have_content transporter.corporate_name
    expect(page).to have_content attr.corporate_name
    expect(page).to have_content attr.brand_name
    expect(page).to have_content transporter.domain
    expect(page).to have_content transporter.full_address
  end

  it 'changing status to inactive' do
    sign_in create(:user, admin: true)
    transporter = create(:transporter)

    visit transporter_path(transporter.id)
    click_on 'Editar transportadora'
    choose 'transporter_stats_inactive'
    click_on 'Atualizar Transportadora'
    transporter.reload

    expect(page).to have_current_path transporter_path(transporter.id)
    expect(page).to have_content 'Inativo'
  end

  it 'with invalid attributes' do
    sign_in create(:user, admin: true)
    transporter = create(:transporter)

    visit transporter_path(transporter.id)
    click_on 'Editar transportadora'
    fill_in 'Nome Fantasia:', with: ''
    fill_in 'Razão Social:', with: ''
    click_on 'Atualizar Transportadora'

    expect(page).to have_content 'Atualizar transportadora'
    expect(page).to have_content 'Verifique os erros abaixo:'
    expect(page).to have_content 'Não foi possivel atualizar a transportadora.'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_link 'Voltar'
  end
end
