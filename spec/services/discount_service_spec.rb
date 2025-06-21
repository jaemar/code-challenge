require "rails_helper"

RSpec.describe DiscountService, type: :service do
  describe "Buy One Get One: Item price EUR 3.11" do
    let(:product) { create(:green_tea_product) }

    it "returns 3.11 for 2 items" do
      items_count = 2
      cart = create(:cart_with_bogo_discount, items_count: items_count)
      discount_service = DiscountService.new(cart)

      expect(discount_service.discounted_total).to eq(Money.new(product.price_cents))
    end

    it "return 6.22 for 3 items" do
      # Customer should only pay for the price of 2 items
      # as the other item should be the "GET ONE" free
      items_count = 3
      cart = create(:cart_with_bogo_discount, items_count: items_count)
      discount_service = DiscountService.new(cart)

      expect(discount_service.discounted_total).to eq(Money.new(product.price_cents * 2))
    end
  end

  describe "BULK: Item price EUR 5.00" do
    let(:product) { create(:strawberry_product) }

    it "returns 10.00 for 2 items" do
      items_count = 2
      cart = (create(:cart_with_bulk_discount, items_count: items_count))
      discount_service = DiscountService.new(cart)
      expect(discount_service.discounted_total).to eq(Money.new(product.price_cents * items_count))
    end

    it "returns 4.50 per items for 3 items" do
      # 450 should be the new price for 3 items and above
      items_count = 3
      cart = (create(:cart_with_bulk_discount, items_count: items_count))
      discount_service = DiscountService.new(cart)
      expect(discount_service.discounted_total).to eq(Money.new(450 * items_count))
    end

    it "returns 4.50 per items for 4 items" do
      # 450 should be the new price for 3 items and above
      items_count = 4
      cart = (create(:cart_with_bulk_discount, items_count: items_count))
      discount_service = DiscountService.new(cart)
      expect(discount_service.discounted_total).to eq(Money.new(450 * items_count))
    end
  end

  describe "PERCENTAGE: Item price EUR 11.23" do
    let(:product) { create(:coffee_product) }

    it "returns 22.46 for 2 items" do
      items_count = 2
      cart = (create(:cart_with_percentage_discount, items_count: items_count))
      discount_service = DiscountService.new(cart)
      expect(discount_service.discounted_total).to eq(Money.new(product.price_cents * items_count))
    end

    it "returns 2/3 or price per items for 3 items" do
      items_count = 3
      cart = (create(:cart_with_percentage_discount, items_count: items_count))
      discount_service = DiscountService.new(cart)
      expect(discount_service.discounted_total).to eq(Money.new(2246))
    end

    it "returns 2/3 or price per items for 4 items" do
      items_count = 4
      cart = (create(:cart_with_percentage_discount, items_count: items_count))
      discount_service = DiscountService.new(cart)
      expect(discount_service.discounted_total).to eq(Money.new(2995))
    end
  end
end
