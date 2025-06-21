FactoryBot.define do
  factory :item do
    cart
    product
    price { product.price }

    factory :green_tea_item do
      transient do
        green_tea_product { Product.find_by(code: "GR1") || create(:green_tea_product) }
      end
      product { green_tea_product }
      price { product.price }
    end
  end
end
