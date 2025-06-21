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
      data = body["data"]

      expect(data["type"]).to eq("cart")
      expect(data["attributes"].keys).to eq([ "total_price", "basket", "formatted_total_price", "currency_in_symbol", "currency_in_word" ])
    end
  end

  describe "POST /api/v1/carts/:id" do
    let(:cart) { create(:cart_with_bulk_discount, items_count: 3) }

    it "returns cart json" do
      get api_v1_cart_url(cart.id)
      body = JSON.parse(response.body)
      data = body["data"]

      expect(data["type"]).to eq("cart")
      expect(data["attributes"].keys).to eq([ "total_price", "basket", "formatted_total_price", "currency_in_symbol", "currency_in_word" ])
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
end
