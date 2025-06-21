require "rails_helper"

RSpec.describe "Carts API", type: :request do
  describe "POST /api/v1/carts" do
    it "creates new cart" do
      expect do
        post api_v1_carts_url
      end.to change(Cart, :count).by(1)
    end
  end

  describe "GET /api/v1/cart/:id" do
    before do
      @cart = Cart.create
    end

    it "returns cart details" do
      get api_v1_cart_url(@cart.id)
      body = JSON.parse(response.body)

      expect(body.keys).to eq([ :id, :total_price, :items ])
    end

    describe "calculate total price for buy-one-get-one discount" do
      it "returns total price of one (1) Green Tea" do
        get api_v1_cart_url(@cart.id)
        cart = JSON.parse(response.body)
        expect(cart.total_price).to eq(Product.find_by(code: "GR1").price)
      end

      it "returns double items for Green Tea" do
        gr1 = Product.find_by(code: "GR1")
        grouped_items = @cart.items.group_by(&:product_id).transform_values(&:count)
        gr1_count = grouped_items[gr1.id]

        get api_v1_cart_url(@cart.id)
        cart = JSON.parse(response.body)

        expect(cart.items).to eq(gr1_count * 2)
      end
    end

    describe "calculate total price for buy-one-get-one discount" do
      it "returns total price of one (1) Green Tea" do
        get api_v1_cart_url(@cart.id)
        cart = JSON.parse(response.body)
        expect(cart.total_price).to eq(Product.find_by(code: "GR1").price)
      end

      it "returns double items for Green Tea" do
        gr1 = Product.find_by(code: "GR1")
        grouped_items = @cart.items.group_by(&:product_id).transform_values(&:count)
        gr1_count = grouped_items[gr1.id]

        get api_v1_cart_url(@cart.id)
        cart = JSON.parse(response.body)

        expect(cart.items).to eq(gr1_count * 2)
      end
    end
  end
end
