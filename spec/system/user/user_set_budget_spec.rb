# frozen_string_literal: true

require 'rails_helper'

describe 'user accesses set budget screen' do
  it 'and see set budget page' do
    transporter = create(:transporter)

    sign_in create(:user)
    visit transporter_path(transporter.id)
    click_on 'Configurar orçamento'

    expect(page).to have_current_path new_budget_path
    expect(page).to have_content 'Orçamentos'
    expect(page).to have_field 'Tamanho máximo (m³):'
    expect(page).to have_link 'Voltar'
  end

  it 'and set a budget' do
    transporter = create(:transporter)
    attr = build(:budget)

    sign_in create(:user)
    visit transporter_path(transporter.id)
    click_on 'Configurar orçamento'
    fill_in 'Tamanho máximo (m³):', with: attr.max_size
    fill_in 'Tamanho minímo (m³):', with: attr.min_size
    fill_in 'Peso máximo (kg):', with: attr.max_weight
    fill_in 'Peso minímo (kg):', with: attr.min_weight
    fill_in 'Preço (R$):', with: attr.price
    click_on 'Criar Orçamento'

    expect(page).to have_current_path new_budget_path
    expect(page).to have_content 'Orçamento cadastrado com sucesso!'
    expect(page).to have_content "#{attr.min_size} - #{attr.max_size} m³"
    expect(page).to have_content "#{attr.min_weight} - #{attr.max_weight} kg"
    expect(page).to have_content 'R$'
  end

  it 'and set a budget with null attributes' do
    transporter = create(:transporter)

    sign_in create(:user)
    visit transporter_path(transporter.id)
    click_on 'Configurar orçamento'
    fill_in 'Tamanho máximo (m³):', with: ''
    fill_in 'Tamanho minímo (m³):', with: ''
    click_on 'Criar Orçamento'

    expect(page).to have_current_path budgets_path
    expect(page).to have_content 'Não foi possivel criar a orçamento.'
    expect(page).to have_content 'Tamanho máximo não pode ficar em branco'
    expect(page).to have_content 'Tamanho minímo não pode ficar em branco'
  end
end
