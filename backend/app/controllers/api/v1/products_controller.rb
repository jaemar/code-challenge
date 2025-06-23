module Api
  module V1
    class ProductsController < ApplicationController
      def index
        products = Product.all
        render_json(products)
      end

      def create
        product = Product.create!(product_params)
        render_json(product, status: :created)
      rescue ActiveRecord::RecordInvalid => e
        render_error(e.message, status: :unprocessable_entity)
      rescue
        render_error("Internal Server Error")
      end

      private

      def product_params
        params.permit(:code, :name, :price)
      end
    end
  end
end
