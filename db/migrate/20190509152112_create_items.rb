# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :quantity, default: 1
      # t.references :product, foreign_key: true, index: true
      t.belongs_to :cart, foreign_key: true, index: true
      t.belongs_to :product
      t.timestamps
    end
  end
end
