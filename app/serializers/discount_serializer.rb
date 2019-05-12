# frozen_string_literal: true

class DiscountSerializer < ActiveModel::Serializer
  attributes :id, :kind, :name, :product_ids

  attribute :price, if: :is_set?
  attribute :count, if: :is_extra?

  #split discounts for set and extras as was in the task
  def is_set?
    object.kind == 'set'
  end

  def is_extra?
    object.kind == 'extra'
  end
end
