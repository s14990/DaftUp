# frozen_string_literal: true

module Carts
  class ItemsController < ApplicationController
    def create
      cart.items.create!(item_params)
      render json: cart, include: '**'
    end

    def update
      item.update!(item_update_params)
      render json: cart, include: '**'
    end

    private

    def item_params
      params.permit(:product_id, :quantity)
    end

    def item_update_params
      params.permit(:quantity)
    end

    def cart
      @cart ||= Cart.first_or_create
    end

    def product
      @product ||= Product.find(params[:product_id])
    end

    def item
      @item ||= cart.items.find(params[:id])
    end
  end
end
