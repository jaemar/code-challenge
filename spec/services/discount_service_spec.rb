require "rails_helper"

RSpec.describe DiscountService, type: :service do
  describe "Buy One Get One: Item price EUR 3.11" do
    let(:product) { create(:green_tea_product) }

    it "returns 3.11 for 2 items" do
      items_count = 2
      cart = create(:cart_with_bogo_discount, items_count: items_count)
      discount_service = DiscountService.new(cart)
      discount_service.discounted_total

      expect(discount_service.discounted_total).to eq(product.price_cents)
    end

    it "return 6.22 for 3 items" do
      # Customer should only pay for the price of 2 items
      # as the other item should be the "GET ONE" free
      items_count = 3
      cart = create(:cart_with_bogo_discount, items_count: items_count)
      discount_service = DiscountService.new(cart)
      discount_service.discounted_total

      expect(discount_service.discounted_total).to eq(product.price_cents * 2)
    end
  end
end
