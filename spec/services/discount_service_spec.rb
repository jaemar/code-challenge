require "rails_helper"

RSpec.describe DiscountService, type: :service do
  before do
    create(:product_set)
  end

  describe "Buy One Get One: Item price EUR 3.11" do
    it "returns 3.11 for 2 items" do
      items_count = 2
      cart = create(:cart_with_bogo_discount, items_count: items_count)
      product = cart.grouped_items.first.product
      discount_service = DiscountService.new(cart)

      expect(discount_service.discounted_total).to eq(Money.new(product.price_cents))
    end

    it "return 6.22 for 3 items" do
      # Customer should only pay for the price of 2 items
      # as the other item should be the "GET ONE" free
      items_count = 3
      cart = create(:cart_with_bogo_discount, items_count: items_count)
      product = cart.grouped_items.first.product
      discount_service = DiscountService.new(cart)

      expect(discount_service.discounted_total).to eq(Money.new(product.price_cents * 2))
    end
  end

  describe "BULK: Item price EUR 5.00" do
    it "returns 10.00 for 2 items" do
      items_count = 2
      cart = (create(:cart_with_bulk_discount, items_count: items_count))
      product = cart.grouped_items.first.product
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
    it "returns 22.46 for 2 items" do
      items_count = 2
      cart = (create(:cart_with_percentage_discount, items_count: items_count))
      product = cart.grouped_items.first.product
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

  describe "Test data" do
    let(:cart) { create(:cart) }

    it "return 22.45 for GR1, SR1, GR1, GR1, CF1" do
      create(:green_tea_item, cart: cart)
      create(:strawberry_item, cart: cart)
      create(:green_tea_item, cart: cart)
      create(:green_tea_item, cart: cart)
      create(:coffee_item, cart: cart)

      discount_service = DiscountService.new(cart)
      expect(discount_service.discounted_total).to eq(Money.new(2245))
    end

    it "return 3.11 for GR1, GR1" do
      create(:green_tea_item, cart: cart)
      create(:green_tea_item, cart: cart)

      discount_service = DiscountService.new(cart)
      expect(discount_service.discounted_total).to eq(Money.new(311))
    end

    it "return 16.61 for SR1, SR1, GR1, SR1" do
      create(:strawberry_item, cart: cart)
      create(:strawberry_item, cart: cart)
      create(:green_tea_item, cart: cart)
      create(:strawberry_item, cart: cart)

      discount_service = DiscountService.new(cart)
      expect(discount_service.discounted_total).to eq(Money.new(1661))
    end

    it "return 30.57 for GR1, CF1, SR1, CF1, CF1" do
      create(:green_tea_item, cart: cart)
      create(:coffee_item, cart: cart)
      create(:strawberry_item, cart: cart)
      create(:coffee_item, cart: cart)
      create(:coffee_item, cart: cart)

      discount_service = DiscountService.new(cart)
      expect(discount_service.discounted_total).to eq(Money.new(3057))
    end
  end
end
