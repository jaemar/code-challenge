class CartSerializer
  include JSONAPI::Serializer

  attribute :total_price do |cart|
    cart.total
  end

  attribute :basket do |cart|
    cart.items.map { |item| item.product.code }.join(",")
  end

  attribute :formatted_total_price do |cart|
    cart.total.format
  end

  attribute :currency_in_symbol do |cart|
    cart.total.currency.symbol
  end

  attribute :currency_in_word do |cart|
    cart.total.currency.iso_code
  end
end
