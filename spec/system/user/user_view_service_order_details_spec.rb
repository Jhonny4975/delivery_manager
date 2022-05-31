# frozen_string_literal: true

require 'rails_helper'

describe 'user view service order details' do
  it 'must see additional information' do
    transporter = create(:transporter)
    user = create(:user)
    service_order = create(:service_order, transporter: transporter)
    size = service_order.height * service_order.width * service_order.length

    sign_in user
    visit user_root_path
    click_on 'Ver detalhes'

    expect(page).to have_current_path service_order_path(service_order.id)
    expect(page).to have_content "Tamanho do produto (m³): #{size}"
    expect(page).to have_content "Peso do produto (kg): #{service_order.weight}"
    expect(page).to have_content "Distância (km): #{service_order.distance}"
    expect(page).to have_content "Endereço de retirada: #{service_order.pickup_address}"
    expect(page).to have_content "Endereço de entrega: #{service_order.delivery_address}"
    expect(page).to have_content "Código do produto: #{service_order.sku}"
    expect(page).to have_content "Nome do destinatário: #{service_order.recipient_name}"
    expect(page).to have_content "Telefone do destinatário: #{service_order.recipient_phone_number}"
    expect(page).to have_content "CPF do destinatário: #{service_order.recipient_document}"
    expect(page).to have_content "Status: #{ServiceOrder.human_enum_name(:stats, service_order.stats)}"
    expect(page).to have_link 'Voltar'
  end

  it 'and back to user root path' do
    transporter = create(:transporter)
    create(:service_order, transporter: transporter)

    sign_in create(:user)
    visit user_root_path
    click_on 'Ver detalhes'
    click_on 'Voltar'

    expect(page).to have_current_path user_root_path
  end
end
