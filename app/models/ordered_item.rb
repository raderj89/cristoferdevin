class OrderedItem < ActiveRecord::Base

  # Relations
  belongs_to :cart
  belongs_to :product
  belongs_to :order

  # Methods
  def total_price
    product.price * quantity
  end
end
