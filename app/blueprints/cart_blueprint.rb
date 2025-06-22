class CartBlueprint < Blueprinter::Base
  identifier :id

  fields :total_price

  field :basket do |cart|
    cart.items.map { |item| item.product.code }.join(", ")
  end

  field :currency do |cart|
    cart.total_price.currency.symbol
  end
end
