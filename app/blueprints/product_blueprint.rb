class ProductBlueprint < Blueprinter::Base
  identifier :id

  fields :code, :price

  field :currency do |product|
    product.price.currency.symbol
  end
end
