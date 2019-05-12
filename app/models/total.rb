# frozen_string_literal: true

class Total < ApplicationRecord
  belongs_to :cart
  has_many :bundles, dependent: :destroy
  has_many :items
  
end
