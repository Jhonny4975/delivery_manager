# frozen_string_literal: true

class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[show]

  def index
    @vehicles = Vehicle.all

    flash.now[:notice] = 'Não existem veículos cadastrados.' if @vehicles.empty?
  end

  def show; end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)

    if @vehicle.save
      redirect_to @vehicle, notice: 'Veículo cadastrado com sucesso!'
    else
      flash.now[:notice] = 'Veículo não cadastrado.'

      render :new
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(
      :license_plate,
      :brand_name,
      :model,
      :year,
      :capacity
    )
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end
end
