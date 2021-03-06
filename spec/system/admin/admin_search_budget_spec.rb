# frozen_string_literal: true

require 'rails_helper'

describe 'admin access the budget search barr' do
  it 'and see a search form' do
    sign_in create(:user, admin: true)
    visit user_root_path

    expect(page).to have_content 'Consultar orçamentos'
    expect(page).to have_field 'Altura do produto'
    expect(page).to have_field 'Comprimento do produto'
    expect(page).to have_field 'Largura do produto'
    expect(page).to have_field 'Peso do produto'
    expect(page).to have_field 'Distância'
    expect(page).to have_button 'Consultar'
  end

  it 'and search for budgets' do
    create(:transporter)
    first_transporter = create(:transporter)
    second_transporter = create(:transporter)
    create(:budget, min_weight: 0.1, max_weight: 30, min_size: 0.5, max_size: 2, transporter: first_transporter)
    create(:deadline, max_distance: 200, min_distance: 1, transporter: first_transporter)
    create(:budget, min_weight: 0.1, max_weight: 30, min_size: 0.5, max_size: 2, transporter: second_transporter)
    create(:deadline, max_distance: 200, min_distance: 1, transporter: second_transporter)

    sign_in create(:user, admin: true)
    visit user_root_path
    fill_in 'Altura do produto', with: 1
    fill_in 'Comprimento do produto', with: 1
    fill_in 'Largura do produto', with: 1.5
    fill_in 'Peso do produto', with: 10
    fill_in 'Distância', with: 150
    click_on 'Consultar'

    expect(page).to have_content 'Orçamentos disponíveis:'
    expect(page).to have_content 'Transportadora'
    expect(page).to have_content 'Preço'
    expect(page).to have_content 'Prazo'
    expect(page).to have_content first_transporter.brand_name
    expect(page).to have_content second_transporter.brand_name
    expect(page).to have_content number_to_currency(first_transporter.budget.first.price * 150)
    expect(page).to have_content number_to_currency(second_transporter.budget.last.price * 150)
    expect(page).to have_content "#{first_transporter.deadline.first.period} dia(s)"
    expect(page).to have_content "#{second_transporter.deadline.last.period} dia(s)"
    expect(page).to have_link 'Voltar'
  end

  it 'and there are no two quotes from the same transporter' do
    first_transporter = create(:transporter, min_price: 300)
    create(:budget, price: 0.5, min_weight: 0.1, max_weight: 30,
                    min_size: 0.5, max_size: 2, transporter: first_transporter)
    create(:deadline, period: 2, max_distance: 200, min_distance: 1, transporter: first_transporter)
    create(:budget, price: 0.7, min_weight: 30, max_weight: 50, min_size: 2,
                    max_size: 3, transporter: first_transporter)
    create(:deadline, period: 4, max_distance: 300, min_distance: 200, transporter: first_transporter)

    sign_in create(:user, admin: true)
    visit user_root_path
    fill_in 'Altura do produto', with: 1
    fill_in 'Comprimento do produto', with: 1
    fill_in 'Largura do produto', with: 2
    fill_in 'Peso do produto', with: 30
    fill_in 'Distância', with: 200
    click_on 'Consultar'

    within('section div table') do
      expect(page).to have_content first_transporter.brand_name, maximum: 1
    end
    expect(page).to have_content number_to_currency(first_transporter.min_price)
    expect(page).to have_content "#{first_transporter.deadline.first.period} dia(s)"
    expect(page).not_to have_content "#{first_transporter.deadline.last.period} dia(s)"
  end

  it 'and does not display inactive transporters' do
    transporter = create(:transporter, min_price: 300, stats: 'inactive')
    create(:budget, price: 0.5, min_weight: 0.1, max_weight: 30,
                    min_size: 0.5, max_size: 2, transporter: transporter)
    create(:deadline, period: 2, max_distance: 200, min_distance: 1, transporter: transporter)

    sign_in create(:user, admin: true)
    visit user_root_path
    fill_in 'Altura do produto', with: 1
    fill_in 'Comprimento do produto', with: 1
    fill_in 'Largura do produto', with: 2
    fill_in 'Peso do produto', with: 30
    fill_in 'Distância', with: 200
    click_on 'Consultar'

    expect(page).not_to have_content transporter.brand_name
    expect(page).not_to have_content number_to_currency(transporter.min_price)
    expect(page).not_to have_content "#{transporter.deadline.first.period} dia(s)"
  end

  it 'and there is no budgets' do
    sign_in create(:user, admin: true)
    visit user_root_path
    fill_in 'Altura do produto', with: 1
    fill_in 'Comprimento do produto', with: 1
    fill_in 'Largura do produto', with: 1.5
    fill_in 'Peso do produto', with: 10
    fill_in 'Distância', with: 150
    click_on 'Consultar'

    expect(page).to have_current_path user_root_path
    expect(page).to have_content 'Não houve resultados para sua consulta...'
  end
end
