# frozen_string_literal: true

class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all

    flash.now[:notice] = 'Não existem veículos cadastrados.' if @vehicles.empty?
  end
end
