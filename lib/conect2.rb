require "config/environment.rb"
order = Order.find(1)
order.name = "Dave Thomas"
order.save
