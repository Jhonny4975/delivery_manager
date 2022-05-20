# frozen_string_literal: true

class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :license_plate, index: { unique: true, name: 'unique_license_plate' }, null: false
      t.string :brand_name, null: false
      t.string :model, null: false
      t.string :year
      t.string :capacity, null: false

      t.timestamps
    end
  end
end
