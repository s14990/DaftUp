# frozen_string_literal: true

class Bundle < ApplicationRecord
  scope :sets, -> { where(kind: 'set') }
  scope :extras, -> { where(kind: 'extra') }

  # i was considering making STI for discounts, but it would require aditional handling in update
  # and during total serialization there would be a problem with extra (they can have many types of products)
end
