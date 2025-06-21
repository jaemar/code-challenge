module Api
  module V1
    class CartsController < ApplicationController
      def create
        cart = Cart.create(total_price: 0)

        render_jsonapi(cart)
      end

      def show
        cart = Cart.find(params[:id])
        render_jsonapi(cart)
      rescue => e
        render json: { error: { message: e.message } }
      end
    end
  end
end
