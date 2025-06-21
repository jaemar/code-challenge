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
      expect(data["attributes"].keys).to eq([ "total_price_cents", "basket", "formatted_total_price", "currency_in_symbol", "currency_in_word" ])
    end
  end
end
