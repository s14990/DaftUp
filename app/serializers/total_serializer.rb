# frozen_string_literal: true

class TotalSerializer < ActiveModel::Serializer
  attributes :sets, :extras, :regular_products, :regular_price, :total_price, :savings

  # Added total price and regular price so we can be proud of how much we saved ':)

  def sets
    my_sets = []
    object.bundles.sets.each do |set|
      my_sets.push(BundleSerializer.new(set))
    end
    my_sets
  end

  def extras
    my_extras = []
    object.bundles.extras.each do |extra|
      my_extras.push(BundleSerializer.new(extra))
    end
    my_extras
  end

  def regular_products
    my_products = []
    object.product_ids.each do |product_id|
      my_products.push(ProductSerializer.new(Product.find(product_id)))
    end
    my_products
  end

  def savings
    saving = object.regular_price - object.total_price
    saving.round(2)
  end
end
