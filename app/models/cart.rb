class Cart < ApplicationRecord
  has_many :items

  monetize :total_price_cents, allow_nil: true

  def grouped_items
    items
      .group(:product_id, :price_cents)
      .select(:product_id, :price_cents, "COUNT(*) as quantity", "SUM(price_cents) as subtotal")
  end

  def total
    service = DiscountService.new(self)
    service.discounted_total
  end

  def update_total
    update(total_price: total)
  end
end
