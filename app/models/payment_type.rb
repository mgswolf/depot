class PaymentType < ActiveRecord::Base
  def names
    pay_types = Self.all
    names = []
    pay_types.each do |pay_type|
      names << pay_type.name
    end
    names
  end
end
