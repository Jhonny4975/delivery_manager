# frozen_string_literal: true

require 'rails_helper'

describe 'user checks delivery status' do
  it 'and see the delivery status' do
    service = create(:service_order)

    visit root_path

    fill_in 'Código do pedido:', with: service.code
    click_on 'buscar'

    expect(page).to have_content service.code
    expect(page).to have_content service.pickup_address
    expect(page).to have_content service.delivery_address
    expect(page).to have_content ServiceOrder.human_enum_name(:stats, service.stats)
  end
end
