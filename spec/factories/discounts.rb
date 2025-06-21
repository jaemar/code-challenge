FactoryBot.define do
  factory :discount do
    factory :discount_bogo do
      product
      code { "bogo" }
      condition { {} }
    end

    factory :discount_bulk do
      product
      code { "bulk" }
      condition { { min_quantity: 3, new_price: 450 } }
    end

    factory :discount_percentage do
      product
      code { "percentage" }
      condition { { min_quantity: 3, percentage: 33.33 } }
    end
  end
end
