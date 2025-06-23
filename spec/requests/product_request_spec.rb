require "rails_helper"

RSpec.describe "Product API", type: :request do
  describe "GET /api/v1/products" do
    before do
      create(:green_tea_product)
    end

    it "return list of products" do
      get api_v1_products_url
      body = JSON.parse(response.body)

      expect(body).to be_kind_of(Array)
      expect(body.first.keys).to eq([ "id", "code", "currency", "name", "price" ])
    end
  end

  describe "POST /api/v1/products" do
    let(:params) { { code: "MR1", name: "Mango", price: 2.5 } }

    it "creates new product" do
      expect do
        post api_v1_products_url, params: params
      end.to change(Product, :count).by(1)
    end

    context "Error" do
      it "Invalid or missing params" do
        post api_v1_products_url, params: {}

        body = JSON.parse(response.body)
        error = body["error"]

        expect(error.keys).to eq([ "message" ])
        expect(error["message"]).to eq("Validation failed: Price cents is not a number, Price is not a number, Code can't be blank")
        expect(response.status).to eq(422)
      end

      it "returns duplicate code error" do
        create(:product, code: "MR1", name: "Mango", price: 2.5)
        post api_v1_products_url, params: params

        body = JSON.parse(response.body)
        error = body["error"]

        expect(error["message"]).to eq("Validation failed: Code has already been taken")
        expect(response.status).to eq(422)
      end
    end
  end
end
