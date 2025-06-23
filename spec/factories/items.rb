FactoryBot.define do
  factory :item do
    cart
    product
    price { product.price }

    factory :green_tea_item do
      product {
        Product.find_or_create_by!(code: "GR1") do |product|
          product.name  = "Green Tea"
          product.price = 3.11
        end
      }
      price { product.price }
    end

    factory :strawberry_item do
      product {
        Product.find_or_create_by!(code: "SR1") do |product|
          product.name  = "Strawberry"
          product.price = 5.00
        end
      }
      price { product.price }
    end

    factory :coffee_item do
      transient do
        coffee_product {
          Product.find_or_create_by!(code: "CF1") do |product|
            product.name = "Coffee"
            product.price = 11.23
          end
        }
      end

      product { coffee_product }
      price { product.price }
    end
  end
end
