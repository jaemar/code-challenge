require "rails_helper"

RSpec.describe Product, type: :model do
  before do
    create(:green_tea_product)
  end

  it "validates uniqueness of product code" do
    strawberry = build(:strawberry_product)
    expect(strawberry).to be_valid
  end

  it "does not allow duplicate product code" do
    green_tea = build(:green_tea_product)
    expect(green_tea).not_to be_valid
  end
end
