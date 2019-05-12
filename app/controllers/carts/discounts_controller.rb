# frozen_string_literal: true

module Carts
  class Carts::DiscountsController < ApplicationController
    def create
      cart.discounts.create!(discount_params)
      render json: cart, include: '**'
    end

    def update
      discount.update!(discount_params)
      render json: cart, include: '**'
    end

    private

    def discount_params
      params.permit(:kind, :name, :price, :count, product_ids: [])
    end

    def cart
      @cart ||= Cart.first_or_create
    end

    def discount
      @discount ||= cart.discounts.find(params[:id])
    end
  end
end
