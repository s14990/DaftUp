# frozen_string_literal: true

class CreateBundles < ActiveRecord::Migration[5.2]
  def change
    create_table :bundles do |t|
      t.belongs_to :total
      t.string :kind
      t.string :name
      t.float :total
      t.integer :product_ids, array: true, default: []
      t.timestamps
    end
  end
end
