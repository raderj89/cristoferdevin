class Cart < ActiveRecord::Base
  has_many :ordered_items, dependent: :destroy

  # Methods
  
  # add product to cart
  def add_product(args)
    current_item = ordered_items.find_by(product_id: args[:product_id])
    if current_item
      current_item.quantity += args[:quantity].to_i
      current_item.save
    else
      current_item = ordered_items.build(product_id: args[:product_id], quantity: args[:quantity])
    end
    current_item
  end

  # total order price
  def total_price
    ordered_items.to_a.sum { |item| item.total_price }
  end

  def tax_amount
    total_price * 0.045
  end

  def number_items
    ordered_items.sum(:quantity)
  end

end
