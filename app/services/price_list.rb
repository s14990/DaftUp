# frozen_string_literal: true

class PriceList
 

  #i created this class so i dont need to check price from Products each time 

  def self.init
    @list = Product.all.pluck(:id, :price).map { |id, price| { id: id, price: price } }
  end

  class << self
    attr_reader :list
  end

  #get price of item
  def self.get_price(prod_id:)
    @list.select { |prod| prod[:id] == prod_id }.first[:price]
  end

  #add price of all items ids in the list including dupl
  def self.count(list:)
    sum = 0
    list.each { |id| sum += get_price(prod_id: id) }
    sum
  end
end
