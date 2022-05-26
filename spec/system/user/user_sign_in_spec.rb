# frozen_string_literal: true

require 'rails_helper'

describe 'user accesses login screen' do
  it 'and log in' do
    create(:transporter)
    user = create(:user)

    visit root_path
    click_on 'Fazer login'
    within('form') do
      fill_in 'E-mail', with: user.email
      fill_in 'Senha', with: user.password
      click_on 'Login'
    end

    expect(page).to have_current_path user_root_path
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).to have_content user.email
    expect(page).to have_content user.branch_office_name
    expect(page).to have_link 'Início'
    expect(page).to have_link 'Veículos'
    expect(page).to have_link Transporter.last.brand_name
    expect(page).not_to have_link 'Transportadoras'
    expect(page).to have_button 'Sair'
  end

  it 'and log out' do
    create(:transporter)

    sign_in create(:user)
    visit user_root_path
    click_on 'Sair'

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).not_to have_content User.last.email
    expect(page).not_to have_link 'Início'
  end
end
