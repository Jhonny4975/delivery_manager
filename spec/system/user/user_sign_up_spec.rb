# frozen_string_literal: true

require 'rails_helper'

describe 'user accesses sign up screen' do
  it 'and sign up' do
    create(:transporter)
    attr = build(:user)

    visit root_path
    click_on 'Fazer login'
    click_on 'Nova conta'
    fill_in 'E-mail', with: attr.email
    fill_in 'Nome da filial', with: attr.branch_office_name
    fill_in 'Telefone', with: attr.phone_number
    fill_in 'Senha', with: attr.password
    fill_in 'Confirme sua senha', with: attr.password
    click_on 'Criar Usuário'

    expect(page).to have_current_path user_root_path
    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(page).to have_content attr.email
    expect(page).to have_content attr.branch_office_name
    expect(page).to have_button 'Sair'
    expect(page).to have_link 'Início'
  end

  it 'with null params' do
    visit root_path
    click_on 'Fazer login'
    click_on 'Nova conta'
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirme sua senha', with: ''
    click_on 'Criar Usuário'

    expect(page).to have_content 'Não foi possível salvar usuário: 3 erros.'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
    expect(page).to have_content 'E-mail não corresponde a nenhuma transportadora cadastrada'
  end

  it 'with different passwords' do
    attr = build(:user)

    visit root_path
    click_on 'Fazer login'
    click_on 'Nova conta'
    fill_in 'E-mail', with: attr.email
    fill_in 'Senha', with: attr.password
    fill_in 'Confirme sua senha', with: "#{attr.password}8ad4"
    click_on 'Criar Usuário'

    expect(page).to have_content 'Não foi possível salvar usuário: 3 erros.'
    expect(page).to have_content 'Confirme sua senha não é igual a Senha'
    expect(page).to have_content 'E-mail não corresponde a nenhuma transportadora cadastrada'
  end
end
