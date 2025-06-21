class Item < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  monetize :price_cents
end
