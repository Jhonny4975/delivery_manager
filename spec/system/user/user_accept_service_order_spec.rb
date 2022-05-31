# frozen_string_literal: true

require 'rails_helper'

describe 'user accesses a service order' do
  it 'and choose one of your vehicles to deliver' do
    transporter = create(:transporter)
    create(:service_order, transporter: transporter)
    user = create(:user)
    create(:vehicle, user: user)

    sign_in user
    visit user_root_path
    click_on 'Ver detalhes'
    click_on 'Atualizar status'
    select 'Aceito', from: 'service_order_stats'
    choose 'service_order_vehicle_id_1'
    click_on 'Atualizar Ordem de serviço'

    expect(page).to have_content 'Serviço ataualizado com sucesso!'
    expect(page).to have_content 'Aceito'
  end

  it 'and update deliver status' do
    transporter = create(:transporter)
    service = create(:service_order, transporter: transporter, stats: 5)
    user = create(:user)

    sign_in user
    visit edit_service_order_path(service.id)
    select 'Finalizado', from: 'service_order_stats'
    click_on 'Atualizar Ordem de serviço'

    expect(page).to have_content 'Serviço ataualizado com sucesso!'
    expect(page).to have_content 'Finalizado'
  end
end
