# frozen_string_literal: true

require 'rails_helper'

describe 'visitor accesses home screen' do
  it 'and see sign in option' do
    visit root_path

    expect(page).to have_content 'Gerenciador de Entregas'
    expect(page).to have_link 'Fazer login'
  end

  it 'and access the vehicles screen' do
    visit root_path
    visit transporters_path

    expect(page).to have_content 'You are being redirected.'
    expect(page).to have_link 'redirected'
  end

  it 'and access the transporters screen' do
    visit root_path
    visit vehicles_path

    expect(page).to have_current_path new_user_session_path
    expect(page).to have_content 'Faça login, primiro!'
  end
end
