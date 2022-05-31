# frozen_string_literal: true

require 'rails_helper'

describe "user accesses their transporter's service order list" do
  it 'and view all service orders' do
    transporter = create(:transporter)
    user = create(:user)
    service_order_one = create(:service_order, transporter: transporter)
    service_order_two = create(:service_order, transporter: transporter)

    sign_in user
    visit user_root_path

    expect(page).to have_content 'Ordens de serviço'
    expect(page).to have_content user.transporter.brand_name, count: 3
    expect(page).to have_content service_order_one.code
    expect(page).to have_content ServiceOrder.human_enum_name(:stats, service_order_one.stats)
    expect(page).to have_content service_order_two.code
    expect(page).to have_content ServiceOrder.human_enum_name(:stats, service_order_two.stats)
  end

  it 'and there is no service order' do
    create(:transporter)

    sign_in create(:user)
    visit user_root_path

    expect(page).not_to have_content 'Ordens de serviço'
  end
end
