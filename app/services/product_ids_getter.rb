# frozen_string_literal: true

class ProductIdsGetter
  # probably shouldnt have put this into a new class

  # gather product ids with duplicates from cart
  def self.call(cart:)
    array_ids = []
    cart.items.each do |item|
      array_ids << Array.new(item.quantity, item.product.id)
    end
    array_ids.flatten
  end
end
