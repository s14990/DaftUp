# frozen_string_literal: true

module Carts
  class TotalsController < ApplicationController
    after_action :clear_totals, only: [:show]

    def show
      render json: total
    end

    private

    def cart
      @cart ||= Cart.first_or_create
    end

    def total
      TotalCreator.call(cart: cart)
    end

    # after report total is cleared and all dependent bundles are destroyed
    def clear_totals
      Total.destroy_all
    end
  end
end
