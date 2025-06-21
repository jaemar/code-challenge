require "rails_helper"

RSpec.describe CartService, type: :service do
  describe "Buy One Get One" do
    it "return original price for each items" do
      cart = create(:cart_with_bogo_discount)
      debugger
    end
  end
end
