# frozen_string_literal: true

class ServiceOrdersController < ApplicationController
  before_action :set_service_order, only: %i[show edit update]

  def index
    if ServiceOrder.all.present?
      @service_orders = ServiceOrder.all
    else
      @service_orders = []

      flash[:notice] = 'Não há nenhuma ordem de serviço existente.'
    end
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

  def show
    @size = @service_order.height * @service_order.width * @service_order.length
  end

  def edit
    @vehicles = current_user.vehicle
  end

  def update
    @service_order.update(service_order_params)

    redirect_to user_root_path, notice: 'Serviço ataualizado com sucesso!'
  end

  def tracking
    @tracking = ServiceOrder.find_by(code: params[:code])
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
      :recipient_document,
      :vehicle_id,
      :stats
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

  def set_service_order
    @service_order = ServiceOrder.find(params[:id])
  end
end
