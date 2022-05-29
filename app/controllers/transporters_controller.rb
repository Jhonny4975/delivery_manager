# frozen_string_literal: true

class TransportersController < ApplicationController
  before_action :admin_authenticated?, only: %i[index]
  before_action :set_transporter, only: %i[show edit update]

  def index
    @transporters = Transporter.all

    flash.now[:notice] = 'Não existem transportadoras cadastradas.' if @transporters.empty?
  end

  def show
    @budgets = current_user.transporter&.budget
    @deadlines = current_user.transporter&.deadline
  end

  def new
    @transporter = Transporter.new
  end

  def create
    @transporter = Transporter.new(transporter_params)

    if @transporter.save
      redirect_to @transporter, notice: 'Transportadora cadastrada com sucesso!'
    else
      flash.now[notice] = 'Transportadora não cadastrada.'

      render :new
    end
  end

  def edit; end

  def update
    if @transporter.update(transporter_params)
      redirect_to @transporter, notice: 'Transportadora atualizada com sucesso!'
    else
      flash.now[notice] = 'Não foi possivel atualizar a transportadora.'

      render :edit
    end
  end

  def search
    set_data

    if @transporters.blank? && @prices.blank? && @deadlines.blank?
      flash[:notice] = 'Não houve resultados para sua consulta...'

      redirect_to user_root_path
    end
  end

  private

  def transporter_params
    params.require(:transporter).permit(
      :corporate_name,
      :brand_name,
      :domain,
      :registration_number,
      :full_address
    )
  end

  def search_params
    params.permit(
      :height,
      :length,
      :width,
      :weight,
      :distance
    )
  end

  def set_data
    search_data = BudgetDataFilterService.new(params)
    search_data.call
    search_data.price_calculator(params[:distance])

    @transporters = search_data.transporters
    @deadlines = search_data.deadlines
    @prices = search_data.prices
  end

  def set_transporter
    @transporter = Transporter.find(params[:id])
  end

  def admin_authenticated?
    redirect_to root_path, notice: 'Sem permissão!' unless user_signed_in? && current_user.admin?
  end
end
