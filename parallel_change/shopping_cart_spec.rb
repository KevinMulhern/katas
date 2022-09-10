require "./shopping_cart"

describe "ShoppingCart" do
  it "may just have a single item" do
    shopping_cart = ShoppingCart.new
    shopping_cart.add(10)
    expect(shopping_cart.number_of_products).to eq(1)
  end

  it "has the total price equal to total price of its contents" do
    shopping_cart = ShoppingCart.new
    shopping_cart.add(10)
    expect(shopping_cart.calculate_total_price).to eq(10)
  end

  context "when contains at least one premium item" do
    it "has discount" do
      shopping_cart = ShoppingCart.new
      shopping_cart.add(100)
      expect(shopping_cart.has_discount?).to be true
    end
  end

  context "when all items are cheap" do
    it "does not have discount" do
      shopping_cart = ShoppingCart.new
      shopping_cart.add(10)
      expect(shopping_cart.has_discount?).to be false
    end
  end
end
