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
    expect(page).to have_field 'Tamanho maxímo:'
    expect(page).to have_link 'Voltar'
  end

  it 'and set a budget' do
    transporter = create(:transporter)
    attr = build(:budget)

    sign_in create(:user)
    visit transporter_path(transporter.id)
    click_on 'Configurar orçamento'
    fill_in 'Tamanho maxímo:', with: attr.max_size
    fill_in 'Tamanho minímo:', with: attr.min_size
    fill_in 'Peso maxímo:', with: attr.max_weight
    fill_in 'Peso minímo:', with: attr.min_weight
    fill_in 'Preço:', with: attr.price
    click_on 'Criar Orçamento'

    expect(page).to have_current_path new_budget_path
    expect(page).to have_content attr.max_size
    expect(page).to have_content attr.min_size
    expect(page).to have_content attr.max_weight
    expect(page).to have_content attr.min_weight
    expect(page).to have_content attr.price
  end

  it 'and set a budget with null attributes' do
    transporter = create(:transporter)

    sign_in create(:user)
    visit transporter_path(transporter.id)
    click_on 'Configurar orçamento'
    fill_in 'Tamanho maxímo:', with: ''
    fill_in 'Tamanho minímo:', with: ''
    click_on 'Criar Orçamento'

    expect(page).to have_current_path budgets_path
    expect(page).to have_content 'Não foi possivel criar a linha.'
    expect(page).to have_content 'Tamanho maxímo não pode ficar em branco'
    expect(page).to have_content 'Tamanho minímo não pode ficar em branco'
  end
end
