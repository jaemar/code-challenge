class DiscountService
  def initialize(cart)
    @cart = cart
  end

  def discounted_total
    grouped_items = @cart.grouped_items
    total = 0
    grouped_items.each do |item|
      total += apply_discount(item)
    end
    total
  end

  private

  # Item is a grouped by results from cart.items
  # This contains product_id, price, subtotal, count
  def apply_discount(item)
    product = Product.find(item.product_id)
    discount = product.discount

    case discount.code
    when "bogo"
      apply_bogo(discount.condition, item)
    end
  end

  def apply_bogo(_condition, item)
    bogo_price_cents = item.price_cents * (item.quantity / 2)  # get bogo total price
    bogo_price_cents += item.price_cents * (item.quantity % 2) # add the remaining item's price
  end
end
