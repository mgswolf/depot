# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
payment_types = PaymentType.create([{:name => "Check"},{:name => "Credit card"},{:name => "Purchase order"}])

Product.create(:title=>'Programing Ruby 1.9',
  :description =>
    %{<p>
    Ruby is the fastest growing and most exciting dynamic language out thre. If yout
    need to get working programs delivered fast,
    you should add Ruby to your toolbox.
    </p>},
  :image_url => 'ruby.jpg',
  :price => 49.50)
