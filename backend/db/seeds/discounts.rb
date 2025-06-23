Discount.delete_all

discounts = [
  {
    product: Product.find_by(code: "GR1"),
    code: "bogo",
    condition: {}
  },
  {
    product: Product.find_by(code: "SR1"),
    code: "bulk",
    condition: { min_quantity: 3, new_price: 450 }
  },
  {
    product: Product.find_by(code: "CF1"),
    code: "percentage",
    condition: { min_quantity: 3, percentage: 33.33 }
  }
]


discounts.each do |discount|
  Discount.create(discount)
end
