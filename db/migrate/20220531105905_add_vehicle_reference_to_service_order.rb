# frozen_string_literal: true

class AddVehicleReferenceToServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :service_orders, :vehicle, foreign_key: true
  end
end
