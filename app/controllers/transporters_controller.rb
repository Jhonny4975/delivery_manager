# frozen_string_literal: true

class TransportersController < ApplicationController
  before_action :admin_authenticated?, only: %i[index]
  before_action :set_transporter, only: %i[show edit update min_price]

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

  def min_price; end

  private

  def transporter_params
    params.require(:transporter).permit(
      :corporate_name,
      :brand_name,
      :domain,
      :registration_number,
      :full_address,
      :min_price,
      :stats
    )
  end

  def set_transporter
    @transporter = Transporter.find(params[:id])
  end

  def admin_authenticated?
    redirect_to root_path, notice: 'Sem permissão!' unless user_signed_in? && current_user.admin?
  end
end
