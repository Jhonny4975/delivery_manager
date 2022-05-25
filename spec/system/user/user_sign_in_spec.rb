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

    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).to have_button 'Sair'
    expect(page).to have_content user.email
    expect(page).to have_content user.branch_office_name
  end

  it 'and log out' do
    create(:transporter)
    user = create(:user)

    visit new_user_session_path
    within('form') do
      fill_in 'E-mail', with: user.email
      fill_in 'Senha', with: user.password
      click_on 'Login'
    end
    click_on 'Sair'

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).not_to have_content user.email
  end
end
