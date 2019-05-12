# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :cart, presence: true
  validates :product, presence: true
end
