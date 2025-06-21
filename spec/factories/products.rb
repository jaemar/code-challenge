FactoryBot.define do
  factory :product do
    factory :green_tea_product do
      code  { "GR1" }
      name  { "Green Tea" }
      price { 3.11 }

      after(:create) do |product|
        create(:discount_bogo, product: product)
      end
    end

    factory :strawberry_product do
      code  { "SR1" }
      name  { "Strawberries" }
      price { 5.00 }

      after(:create) do |product|
        create(:discount_bulk, product: product)
      end
    end
  end
end
