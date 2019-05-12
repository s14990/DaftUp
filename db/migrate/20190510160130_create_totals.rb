# frozen_string_literal: true

class CreateTotals < ActiveRecord::Migration[5.2]
  def change
    create_table :totals do |t|
      t.belongs_to :cart
      t.float :regular_price
      t.float :total_price
      t.integer :product_ids, array: true, default: []
      t.timestamps
    end
  end
end
