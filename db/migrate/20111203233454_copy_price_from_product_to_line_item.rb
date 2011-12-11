class CopyPriceFromProductToLineItem < ActiveRecord::Migration
  def up
    line_items = LineItem.all
    line_items.each do |line_item|
      line_item.price = line_item.product.price
      line_item.save
    end
  end

  def down
    line_items = LineItem.all
    line_items.each do |line_item|
      line_item.price = nil
      line_item.save
    end
  end
end
