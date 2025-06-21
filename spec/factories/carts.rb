FactoryBot.define do
  factory :cart do
    factory :cart_with_bogo_discount do
      transient do
        items_count { 1 }
      end

      after(:create) do |cart, evaluator|
        create_list(:green_tea_item, evaluator.items_count, cart: cart)
      end
    end


    factory :cart_with_bulk_discount do
      transient do
        items_count { 1 }
      end

      after(:create) do |cart, evaluator|
        create_list(:strawberry_item, evaluator.items_count, cart: cart)
      end
    end
  end
end
