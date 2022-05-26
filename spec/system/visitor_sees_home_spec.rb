# frozen_string_literal: true

require 'rails_helper'

describe 'visitor accesses home screen' do
  it 'and see sign in option' do
    visit root_path

    expect(page).to have_content 'Gerenciador de Entregas'
    expect(page).to have_link 'Fazer login'
  end

  it 'and access the transporters screen' do
    visit transporters_path

    expect(page).to have_content 'Sem permissão!'
  end

  it 'and access the vehicles screen' do
    visit vehicles_path

    expect(page).to have_current_path new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end
end
