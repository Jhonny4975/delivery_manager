# frozen_string_literal: true

class CreateServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_orders do |t|
      t.decimal :height, null: false
      t.decimal :length, null: false
      t.decimal :width, null: false
      t.decimal :weight, null: false
      t.decimal :distance, null: false
      t.string :pickup_address, null: false
      t.string :recipient_name, null: false
      t.string :recipient_phone_number, null: false
      t.string :recipient_document, null: false
      t.string :delivery_address, null: false
      t.string :code, index: { unique: true, name: 'unique_code' }
      t.string :sku, null: false
      t.integer :stats, null: false, default: 0
      t.references :transporter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
