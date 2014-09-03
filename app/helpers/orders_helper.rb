module OrdersHelper

  def shipping_cost(method)
    case method
    when 'ground'
      'Free'
    when 'two-day'
      '$15.75'
    when 'overnight'
      '$20'
    end
  end

end