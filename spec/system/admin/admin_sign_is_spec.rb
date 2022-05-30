# frozen_string_literal: true

require 'rails_helper'

describe 'admin accesses login screen' do
  it 'and log in' do
    create(:transporter)
    admin = create(:user, admin: true)

    visit root_path
    click_on 'Fazer login'
    within('form') do
      fill_in 'E-mail', with: admin.email
      fill_in 'Senha', with: admin.password
      click_on 'Login'
    end

    expect(page).to have_current_path user_root_path
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).to have_content admin.email
    expect(page).to have_content admin.branch_office_name
    expect(page).to have_link 'Início'
    expect(page).to have_link 'Transportadoras'
    expect(page).to have_link 'Ordens de serviço'
    expect(page).not_to have_link 'Veículos'
    expect(page).not_to have_link Transporter.last.brand_name
    expect(page).to have_button 'Sair'
  end

  it 'and log out' do
    create(:transporter)

    sign_in create(:user, admin: true)
    visit user_root_path
    click_on 'Sair'

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).not_to have_content User.last.email
    expect(page).not_to have_link 'Início'
  end
end
