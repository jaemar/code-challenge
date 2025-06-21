class CartSerializer
  include JSONAPI::Serializer
  attributes :total_price_cents

  attribute :basket do |cart|
    cart.items.map { |item| item.product.code }.join(",")
  end

  attribute :formatted_total_price do |cart|
    cart.total_price.format
  end

  attribute :currency_in_symbol do |cart|
    cart.total_price.currency.symbol
  end

  attribute :currency_in_word do |cart|
    cart.total_price.currency.iso_code
  end
end
