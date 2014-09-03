class OrdersController < ApplicationController
  include CurrentOrder
  before_action :get_cart, except: [:show]
  before_action :set_order, only: [:show]
  before_action :set_ordered_item, only: [:edit, :update]
  
  def show
  end

  # check out form
  def new
    @order = Order.new
  end

  # process order
  def create
    @order = Order.new(order_params)

    @order.add_ordered_items_from_cart(@cart)

    @order.add_shipping_and_tax(params[:order][:shipping_method])
    
    @order.process_credit_card(params[:order], @order.total)

    if @order.order_status == 'processed' && @order.save
      Cart.destroy(session[:cart_id])
      session[:order_id] = @order.id
      OrderConfirmation.order_confirmation(order_params[:billing_email], session[:order_id]).deliver
      flash[:success] = "You've paid!"
      redirect_to confirmation_orders_path
    else
      flash[:error] = "There was a problem processing your order. Please try again."
      render :new
    end
  end

  def order_shipped
    @order = Order.find_by(id: params[:order_id])
    if @order.order_status == "processed"
      @order.update(order_status: "shipped")
    end
    render nothing: true
  end

  def cancel
    @order = Order.find_by(id: params[:order_id])
    @order.update(order_status: "canceled")
    render nothing: true
  end

  private

    def order_params
      params.require(:order).permit(:shipping_first_name, :shipping_last_name, :shipping_address, :shipping_address2,
                                    :shipping_city, :shipping_state, :shipping_zip, :shipping_email, :shipping_phone,
                                    :shipping_method, :billing_first_name, :billing_last_name,
                                    :billing_address, :billing_address2, :billing_city, :billing_state,
                                    :billing_zip, :billing_email, :billing_phone)
    end

    def set_order
      @order = Order.find(session[:order_id])
    end

    def set_ordered_item
      @ordered_item = @order.ordered_items.find_by(id: params[:item_id])
    end
end
