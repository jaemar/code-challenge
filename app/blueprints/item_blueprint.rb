class ItemBlueprint < Blueprinter::Base
  identifier :id

  association :product, blueprint: ProductBlueprint
end
