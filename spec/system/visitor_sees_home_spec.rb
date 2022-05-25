# frozen_string_literal: true

require 'rails_helper'

describe 'visitor accesses home screen' do
  it 'and see sign in option' do
    visit root_path

    expect(page).to have_content 'Gerenciador de Entregas'
    expect(page).to have_link 'Fazer login'
  end
end
