class ItemBlueprint < Blueprinter::Base
  identifier :id

  fields :price

  association :product, blueprint: ProductBlueprint, view: :items
end
