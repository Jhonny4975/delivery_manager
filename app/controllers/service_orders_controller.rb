# frozen_string_literal: true

class ServiceOrdersController < ApplicationController
  def index
    @service_orders = ServiceOrder.all
  end

  def search
    @service_order = ServiceOrder.new
    @search_params = params

    set_data

    if @transporters.blank? && @prices.blank? && @deadlines.blank?
      flash[:notice] = 'Não houve resultados para sua consulta...'

      redirect_to user_root_path
    end
  end

  def create
    @service_order = ServiceOrder.new(service_order_params)

    if @service_order.save
      flash[:notice] = 'Ordem de serviço cadastrada com sucesso!'

      redirect_to service_orders_path
    else
      @search_params = service_order_params
      @transporters = [Transporter.find(service_order_params[:transporter_id].to_i)]

      flash.now[:notice] = 'Não foi possível cadastrar a ordem de serviço.'

      render :new
    end
  end

  private

  def service_order_params
    params.require(:service_order).permit(
      :height,
      :length,
      :width,
      :weight,
      :distance,
      :sku,
      :transporter_id,
      :pickup_address,
      :delivery_address,
      :recipient_name,
      :recipient_phone_number,
      :recipient_document
    )
  end

  def set_data
    search_data = BudgetDataFilterService.new(@search_params)
    search_data.call
    search_data.price_calculator(@search_params[:distance])

    @transporters = search_data.transporters
    @deadlines = search_data.deadlines
    @prices = search_data.prices
  end
end
