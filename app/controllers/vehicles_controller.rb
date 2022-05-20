# frozen_string_literal: true

class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[show]

  def index
    @vehicles = Vehicle.all

    flash.now[:notice] = 'Não existem veículos cadastrados.' if @vehicles.empty?
  end

  def show; end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end
end
