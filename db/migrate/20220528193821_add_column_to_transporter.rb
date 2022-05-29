# frozen_string_literal: true

class AddColumnToTransporter < ActiveRecord::Migration[7.0]
  def change
    add_column :transporters, :min_price, :decimal, default: 0.0
  end
end
