# frozen_string_literal: true

class BundleSerializer < ActiveModel::Serializer
  attributes :name, :products, :total

  def products
    my_products = []
    object.product_ids.each do |product_id|
      my_products.push(ProductSerializer.new(Product.find(product_id)))
    end
    my_products
  end
end
