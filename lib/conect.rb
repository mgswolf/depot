require "rubygems"
require "active_record"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3",:database => "db/development.sqlite3")

Class Order < ActiveRecord::Base
end

order = Order.find(1)
order.name = "Dave Thomas"
order.save
