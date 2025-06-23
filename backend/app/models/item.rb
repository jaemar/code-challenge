class Item < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  monetize :price_cents

  after_commit :update_cart_total

  private

  def update_cart_total
    cart&.update_total
  end
end
