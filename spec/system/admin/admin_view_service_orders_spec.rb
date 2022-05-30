# frozen_string_literal: true

require 'rails_helper'

describe 'administrator access the service order listing' do
  it 'and see all service orders' do
    create_list(:service_order, 5)

    sign_in create(:user, admin: true)
    visit user_root_path
    click_on 'Ordens de serviço'

    expect(page).not_to have_content 'Não há nenhuma ordem de serviço existente.'
    expect(page).to have_content ServiceOrder.last.transporter.brand_name
    expect(page).to have_content ServiceOrder.last.code
    expect(page).to have_content ServiceOrder.last.stats
  end

  it 'and see a message' do
    sign_in create(:user, admin: true)
    visit user_root_path
    click_on 'Ordens de serviço'

    expect(page).to have_content 'Não há nenhuma ordem de serviço existente.'
  end
end
