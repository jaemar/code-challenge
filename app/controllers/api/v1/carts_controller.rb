module Api
  module V1
    class CartsController < ApplicationController
      def create
        cart = Cart.create(total_price: 0)
        render_jsonapi(cart)
      end
    end
  end
end
