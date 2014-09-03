class OrderConfirmation < ActionMailer::Base

  def order_confirmation(email, order_id)
    @confirmation = Order.find(order_id)
    mail to: email, from: "no-reply@example.com", subject: "Order Confirmation"
  end
end
