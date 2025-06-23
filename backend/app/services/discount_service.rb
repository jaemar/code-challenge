class DiscountService
  def initialize(cart)
    @cart = cart
  end

  def discounted_total
    total         = 0
    grouped_items = @cart.grouped_items

    grouped_items.each do |item|
      total += apply_discount(item)
    end
    Money.new(total)
  end

  private

  # Item is a grouped by results from cart.items
  # This contains product_id, price, subtotal, count
  def apply_discount(item)
    product  = Product.find(item.product_id)
    discount = product.discount

    return item.subtotal unless discount

    case discount.code
    when "bogo"
      apply_bogo(discount.condition, item)
    when "bulk"
      apply_bulk(discount.condition, item)
    when "percentage"
      apply_percentage(discount.condition, item)
    end
  end

  def apply_bogo(_condition, item)
    bogo_price_cents = item.price_cents * (item.quantity / 2)  # get bogo total price
    bogo_price_cents += item.price_cents * (item.quantity % 2) # add the remaining item's price
  end

  def apply_bulk(condition, item)
    min_qty   = condition["min_quantity"] || 0
    new_price = condition["new_price"]
    return item.subtotal if item.quantity < min_qty

    item.quantity * new_price
  end

  def apply_percentage(condition, item)
    min_qty = condition["min_quantity"] || 0
    percentage = (condition["percentage"] || 0) / 100

    return item.subtotal if item.quantity < min_qty

    discount = item.subtotal * percentage
    item.subtotal - discount
  end
end
