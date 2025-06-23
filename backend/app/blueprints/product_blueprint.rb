class ProductBlueprint < Blueprinter::Base
  identifier :id

  view :default do
    fields :code, :price, :name
  end

  field :currency do |product|
    product.price.currency.symbol
  end

  view :items do
    fields :code, :name
  end
end
