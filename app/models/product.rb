class Product < ApplicationRecord
  has_one :discount, -> { order(created_at: :desc) }, class_name: "Discount"
  monetize :price_cents

  validates :code, presence: true, uniqueness: true
end
