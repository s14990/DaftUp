# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_190_511_181_934) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'bundles', force: :cascade do |t|
    t.bigint 'total_id'
    t.string 'kind'
    t.string 'name'
    t.float 'total'
    t.integer 'product_ids', default: [], array: true
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['total_id'], name: 'index_bundles_on_total_id'
  end

  create_table 'carts', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'discounts', force: :cascade do |t|
    t.bigint 'cart_id'
    t.string 'kind'
    t.string 'name'
    t.integer 'product_ids', default: [], array: true
    t.float 'price'
    t.integer 'count'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['cart_id'], name: 'index_discounts_on_cart_id'
    t.index ['name'], name: 'index_discounts_on_name', unique: true
  end

  create_table 'items', force: :cascade do |t|
    t.integer 'quantity', default: 1
    t.bigint 'cart_id'
    t.bigint 'product_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['cart_id'], name: 'index_items_on_cart_id'
    t.index ['product_id'], name: 'index_items_on_product_id'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'name'
    t.float 'price'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_products_on_name', unique: true
  end

  create_table 'totals', force: :cascade do |t|
    t.bigint 'cart_id'
    t.float 'regular_price'
    t.float 'total_price'
    t.integer 'product_ids', default: [], array: true
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['cart_id'], name: 'index_totals_on_cart_id'
  end

  add_foreign_key 'discounts', 'carts'
  add_foreign_key 'items', 'carts'
end
