require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "#grouped_items" do
    before do
      @cart = create(:cart_with_bulk_discount, items_count: 2)
      create(:green_tea_item, cart: @cart)
      @grouped_items = @cart.grouped_items
    end

    it "returns array Items" do
      expect(@grouped_items.all?(Item)).to be_truthy
    end

    it "returns grouped item" do
      product_1 = @grouped_items.find { |item| item.product_id == @cart.items.first.product_id }
      expect(product_1.quantity).to eq(2)
      expect(product_1.price_cents).to eq(500)
      expect(product_1.subtotal).to eq(1000)
    end
  end

  describe "#total" do
    before do
      @cart = create(:cart_with_bulk_discount)
    end

    it "returns Money instance" do
      expect(@cart.total).to be_a Money
    end

    it "returns 500" do
      expect(@cart.total.cents).to eq(500)
    end

    it "return 0 for cart without items" do
      cart = create(:cart)
      expect(cart.total.cents).to eq(0)
    end
  end
end
