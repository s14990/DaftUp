# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  subject(:cart) { Cart.create }
  subject(:product) { create(:product) }
  subject(:item) { Item.create(cart: cart, product: product) }

  context(' valid data ') do
    it 'should be valid' do
      expect(item).to be_valid
    end

    it 'should have product' do
      expect(item.product).to eq(product)
    end
  end

  context('invalid data ') do
    it 'should be valid' do
      item.cart = nil
      expect(item).to be_invalid
    end
  end
end
