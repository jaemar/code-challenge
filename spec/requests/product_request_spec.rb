require "rails_helper"

RSpec.describe "Product API", type: :request do
  describe "GET /api/v1/products" do
    before do
      create(:green_tea_product)
    end

    it "return list of products" do
      get api_v1_products_url
      body = JSON.parse(response.body)

      debugger
      expect(body).to be_kind_of(Array)
      expect(body.first.keys).to eq([ "id", "code", "currency" "price" ])
    end
  end
end
