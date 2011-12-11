require 'test_helper'

class CartTest < ActiveSupport::TestCase
  def new_cart_with_one_product(product_name)
    cart = Cart.create
    cart.add_product(products(product_name).id)
    cart
  end

  test "new cart should be empty cart" do
    cart = Cart.new
    assert cart.line_items.empty?
  end

  test "cart should create a new line item when adding a new product" do
    cart = Cart.new
    cart.add_product(products(:one).id)
    assert_equal 1, cart.line_items.count
    # Add a new product
    cart.add_product(products(:ruby).id)
    assert_equal 2, cart.line_items.count
  end

  test "cart should update an existing line item when adding an existing product" do
    cart = new_cart_with_one_product(:one)
    # Re-add the same product
    cart.add_product(products(:one).id)
    assert_equal 1, cart.line_items.count
  end
end
