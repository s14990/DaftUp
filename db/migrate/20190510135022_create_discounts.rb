# frozen_string_literal: true

class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.belongs_to :cart, foreign_key: true, index: true
      t.string :kind
      t.string :name, index: { unique: true }
      t.integer :product_ids, array: true, default: []
      t.float :price
      t.integer :count

      t.timestamps
    end
  end
end
