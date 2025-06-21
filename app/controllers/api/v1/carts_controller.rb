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

      def add_to_basket
        cart = Cart.find(params[:id])
        product = Product.find(item_params[:product_id])
        cart.items.create!(product: product, price: product.price)

        render_jsonapi(cart)
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: { message: e.message } }
      rescue ActionController::ParameterMissing
        render json: { error: { message: "Item params missing" } }
      end

      private

      def item_params
        params.require(:item).permit(:product_id, :price)
      end
    end
  end
end
