# frozen_string_literal: true

require 'rails_helper'

describe 'user accesses set deadline screen' do
  it 'and see set deadline page' do
    transporter = create(:transporter)

    sign_in create(:user)
    visit transporter_path(transporter.id)
    click_on 'Configurar prazo'

    expect(page).to have_current_path new_deadline_path
    expect(page).to have_content 'Prazos'
    expect(page).to have_field 'Distância máxima (km):'
    expect(page).to have_link 'Voltar'
  end

  it 'and set a deadline' do
    transporter = create(:transporter)
    attr = build(:deadline)

    sign_in create(:user)
    visit transporter_path(transporter.id)
    click_on 'Configurar prazo'
    fill_in 'Distância máxima (km):', with: attr.max_distance
    fill_in 'Distância miníma (km):', with: attr.min_distance
    fill_in 'prazo (em dias úteis):', with: attr.period
    click_on 'Criar Prazo'

    expect(page).to have_current_path new_deadline_path
    expect(page).to have_content 'Criar novo prazo'
    expect(page).to have_content 'prazo cadastrado.'
    expect(page).to have_content "#{attr.min_distance} - #{attr.max_distance} (km)"
    expect(page).to have_content "#{attr.period} dia(s)"
  end

  it 'and set a deadline with null attributes' do
    transporter = create(:transporter)

    sign_in create(:user)
    visit transporter_path(transporter.id)
    click_on 'Configurar prazo'
    fill_in 'Distância máxima (km):', with: ''
    fill_in 'Distância miníma (km):', with: ''
    click_on 'Criar Prazo'

    expect(page).to have_current_path deadlines_path
    expect(page).to have_content 'Não foi possivel criar o prazo.'
    expect(page).to have_content 'Distância máxima não pode ficar em branco'
    expect(page).to have_content 'Distância miníma não pode ficar em branco'
  end
end
