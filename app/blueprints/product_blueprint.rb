class ProductBlueprint < Blueprinter::Base
  identifier :id

  fields :code, :price, :name

  field :currency do |product|
    product.price.currency.symbol
  end
end
