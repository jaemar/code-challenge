module Api
  module V1
    class CartsController < ApplicationController
      def index
        carts = Cart.all
        render_json(carts)
      end

      def create
        cart = Cart.create(total_price: 0)

        render_json(cart)
      end

      def show
        cart = Cart.find(params[:id])

        render_json(cart, view: :items)
      rescue => e
        render_error(e.message)
      end

      def add_to_basket
        cart = Cart.find(params[:id])
        product = Product.find(item_params[:product_id])
        cart.items.create!(product: product, price: product.price)

        render_json(cart)
      rescue ActiveRecord::RecordNotFound => e
        render_error(e.message, status: :unprocessable_entity)
      rescue ActionController::ParameterMissing
        render_error("Item params missing", status: :bad_request)
      end

      private

      def item_params
        params.require(:item).permit(:product_id, :price)
      end
    end
  end
end
