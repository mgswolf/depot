require 'builder'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'mysql2',
  :database => 'depot_developement'
)

class Product < ActiveRecord::Base
end

class StoreApp
  def call(env)
    x = Builder::XmlMarkup.new :ident => 2

    x.declare! :DOCTYPE, :html
    x.html do
      x.head do
        x.title 'Pragmatic Bookshelf'
      end
      x.body do
        x.h1 'Pragmatic Bookshelf'

        Product.all.each do |product|
          x.h2 product.title
          x << "  #{product.description}\n"
          x.p product.price
        end
      end
    end

    response = Rack::Response.new(x.target!)
    response['Content-Type'] = 'text/html'
    response.finish
  end
end          
