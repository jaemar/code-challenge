class CartBlueprint < Blueprinter::Base
  identifier :id

  fields :total_price

  field :basket do |cart|
    cart.items.map { |item| item.product.code }.join(", ")
  end

  field :currency do |cart|
    cart.total_price.currency.symbol
  end

  view :items do
    field :subtotal do |cart|
      cart.items.sum(&:price)
    end

    field :discount do |cart|
      cart.items.sum(&:price) - cart.total_price
    end

    association :items, blueprint: ItemBlueprint
  end
end
