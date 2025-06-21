FactoryBot.define do
  factory :discount do
    factory :discount_bogo do
      product
      code { "bogo" }
      condition { {} }
    end
  end
end
