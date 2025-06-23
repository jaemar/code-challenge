require "rails_helper"

RSpec.describe 'Cart API', type: :request do
  describe "POST /api/v1/carts" do
    it "creates cart" do
      expect do
        post api_v1_carts_url
      end.to change(Cart, :count).by(1)
    end

    it "returns cart json" do
      post api_v1_carts_url
      body = JSON.parse(response.body)

      expect(body.keys).to eq([ "id", "basket", "currency", "total_price" ])
    end
  end

  describe "GET /api/v1/carts" do
    it "returns empty array" do
      get api_v1_carts_url
      body = JSON.parse(response.body)

      expect(body).to be_empty
    end

    it "returns list of carts" do
      cart = create(:cart_with_bogo_discount)
      get api_v1_carts_url
      body = JSON.parse(response.body)
      data = body.first

      expect(body).to be_kind_of(Array)
      expect(body.count).to be(1)
      expect(data["id"]).to eq(cart.id)
    end
  end

  describe "POST /api/v1/carts/:id" do
    let(:cart) { create(:cart_with_bulk_discount, items_count: 3) }

    it "returns cart json" do
      get api_v1_cart_url(cart.id)
      body = JSON.parse(response.body)

      expect(body.keys).to eq([ "id", "basket", "currency", "discount", "items", "subtotal", "total_price" ])
    end

    context "Errors" do
      it "returns error message for 0 id" do
        get api_v1_cart_url(0)
        body = JSON.parse(response.body)
        error = body["error"]

        expect(error.keys).to eq([ "message" ])
      end

      it "returns error message for non-digit id" do
        get api_v1_cart_url('a')
        body = JSON.parse(response.body)
        error = body["error"]

        expect(error.keys).to eq([ "message" ])
      end
    end
  end

  describe "POST /api/v1/carts/:id/add_to_basket" do
    let(:cart) { create(:cart) }
    let(:green_tea) { create(:green_tea_product) }

    it "adds item in cart" do
      params = {
        item: {
          product_id: green_tea.id,
          price: green_tea.price
        }
      }
      post add_to_basket_api_v1_cart_url(cart.id), params: params
      body = JSON.parse(response.body)

      expect(body.keys).to eq([ "id", "basket", "currency", "total_price" ])
    end

    it "persist item attributes" do
      params = {
        item: {
          product_id: green_tea.id,
          price: green_tea.price
        }
      }
      post add_to_basket_api_v1_cart_url(cart.id), params: params
      item = Item.last

      expect(item.cart_id).to eq(cart.id)
      expect(item.product_id).to eq(green_tea.id)
      expect(item.price).to eq(green_tea.price)
    end

    it "returns total price and basket items" do
      create(:green_tea_item, product: green_tea, cart: cart)
      params = {
        item: {
          product_id: green_tea.id,
          price: green_tea.price
        }
      }
      post add_to_basket_api_v1_cart_url(cart.id), params: params

      body = JSON.parse(response.body)

      expect(body["total_price"]).to eq("3.11")
      expect(body["basket"]).to eq("GR1, GR1")
    end

    context "Errors" do
      it "returns error for cart that does not exists" do
        post add_to_basket_api_v1_cart_url(0)

        body = JSON.parse(response.body)
        error = body["error"]

        expect(error.keys).to eq([ "message" ])
        expect(error["message"]).to eq("Couldn't find Cart with 'id'=0")
      end

      it "returns error for product that does not exists" do
        params = {
          item: {
            product_id: 0
          }
        }
        post add_to_basket_api_v1_cart_url(cart.id), params: params

        body = JSON.parse(response.body)
        error = body["error"]

        expect(error.keys).to eq([ "message" ])
        expect(error["message"]).to eq("Couldn't find Product with 'id'=0")
      end

      it "returns error for missing item params" do
        post add_to_basket_api_v1_cart_url(cart.id)

        body = JSON.parse(response.body)
        error = body["error"]

        expect(error.keys).to eq([ "message" ])
        expect(error["message"]).to eq("Item params missing")
      end
    end
  end
end
