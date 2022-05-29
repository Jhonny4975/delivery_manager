class AddStatsToTransporter < ActiveRecord::Migration[7.0]
  def change
    add_column :transporters, :stats, :integer, default: 0
  end
end
