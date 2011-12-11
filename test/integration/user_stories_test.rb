require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)

    #access index page
    get "/"
    assert_response :success
    assert_template "index"

    #select a product and adding it to heir cart
    xml_http_request :post, '/line_items', :product_id => ruby_book.id
    assert_response :success

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

    #check out
    get "/orders/new"
    assert_response :success
    assert_template "new"

    post_via_redirect "/orders",
                      :order => {:name     => "Dave Thomas",
                                 :address  => "123 The Street",
                                 :email    => "dave@example.com",
                                 :pay_type => "Check"}
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    #Orders
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    assert_equal "Dave Thomas",      order.name
    assert_equal "13 The Street",    order.address
    assert_equal "dave@example.com", order.email
    assert_equal "Check",            order.pay_type

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product

    #send mail
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'ZeRo <mgswolf@gmail.com', mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject

    #send mail at order shiped
    get "/orders/1/edit"
    assert_response :success
    assert_template "edit"

    put_via_redirect "/orders",
                      :order => {:name      => "Dave Thomas",
                                 :address   => "123 The Street",
                                 :email     => "dave@example.com",
                                 :pay_type  => "Check",
                                 :ship_date => "2011/12/06"
                                 }
    assert_response :success
    assert_template "show"

     #send mail
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["mgswolf@gmail.com"], mail.to
    assert_equal 'ZeRo <mgswolf@gmail.com>', mail[:from].value
    assert_equal "Pragamatic Store Order Shipped", mail.subject
  end

  test "should mail the admin when error occurs" do
    get "carts/wibble"
    assert_response :redirect
    assert_template "/"

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["mgswolf@gmail.com"], mail.to
    assert_equal 'ZeRo <mgswolf@gmail.com>', mail[:from].value
    assert_equal "Depot Error Incident", mail.subject
  end

end
