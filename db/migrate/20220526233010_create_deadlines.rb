# frozen_string_literal: true

class CreateDeadlines < ActiveRecord::Migration[7.0]
  def change
    create_table :deadlines do |t|
      t.integer :max_distance, null: false
      t.integer :min_distance, null: false
      t.integer :period, null: false
      t.references :transporter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
