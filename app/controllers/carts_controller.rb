# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    render json: cart, include: '**' #includes all nested serialzers
  end

  private

  def cart
    @cart ||= Cart.first_or_create
  end
end
