# frozen_string_literal: true

require 'rails_helper'

describe 'administrator accesses the create work order screen' do
  it 'and create a service order' do
    attr = build(:service_order)
    transporter = create(:transporter)
    create(:budget, min_weight: 0.1, max_weight: 30, min_size: 0.5, max_size: 2, transporter: transporter)
    create(:deadline, max_distance: 200, min_distance: 1, transporter: transporter)

    sign_in create(:user, admin: true)
    visit search_service_orders_path(weight: 10, height: 1, length: 1, width: 1.5, distance: 150)
    select transporter.brand_name, from: 'service_order_transporter_id'
    fill_in 'Endereço de retirada', with: attr.pickup_address
    fill_in 'Endereço de entrega', with: attr.delivery_address
    fill_in 'Código do produto', with: attr.sku
    fill_in 'Nome do destinatário', with: attr.recipient_name
    fill_in 'Telefone do destinatário', with: attr.recipient_phone_number
    fill_in 'CPF do destinatário', with: attr.recipient_document
    click_on 'Criar Ordem de serviço'

    expect(page).to have_content 'Ordens de serviço'
    expect(page).to have_content 'Ordem de serviço cadastrada com sucesso!'
    expect(page).to have_content transporter.brand_name
    expect(page).to have_content ServiceOrder.last.code
    expect(page).to have_content ServiceOrder.last.stats
    expect(page).to have_link 'Voltar'
  end

  it 'and receive error messages when filling fields with null values' do
    transporter = create(:transporter)
    create(:budget, min_weight: 0.1, max_weight: 30, min_size: 0.5, max_size: 2, transporter: transporter)
    create(:deadline, max_distance: 200, min_distance: 1, transporter: transporter)

    sign_in create(:user, admin: true)
    visit search_service_orders_path(weight: 10, height: 1, length: 1, width: 1.5, distance: 150)
    select transporter.brand_name, from: 'service_order_transporter_id'
    fill_in 'Endereço de retirada', with: ''
    fill_in 'Endereço de entrega', with: ''
    click_on 'Criar Ordem de serviço'

    expect(page).to have_content 'Não foi possível cadastrar a ordem de serviço.'
    expect(page).to have_content 'Endereço de retirada não pode ficar em branco'
    expect(page).to have_content 'Endereço de entrega não pode ficar em branco'
  end
end
