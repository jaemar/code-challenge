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

    factory :coffee_product do
      code  { "CF1" }
      name  { "Coffee" }
      price { 11.23 }

      after(:create) do |product|
        create(:discount_percentage, product: product)
      end
    end
  end

  factory :product_set, class: Object do
    to_create { }
    after(:build) do |_|
      create(:green_tea_product)
      create(:strawberry_product)
      create(:coffee_product)
    end
  end
end
