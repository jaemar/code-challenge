class Cart < ApplicationRecord
  has_many :items

  monetize :total_price_cents, allow_nil: true

  def grouped_items
    items
      .group(:product_id, :price_cents)
      .select(:product_id, :price_cents, "COUNT(*) as quantity", "SUM(price_cents) as subtotal")
  end
end
