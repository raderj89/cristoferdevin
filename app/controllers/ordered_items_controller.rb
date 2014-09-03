class OrderedItemsController < ApplicationController
  include CurrentOrder
  before_action :set_cart, only: [:create, :update, :destroy]
  before_action :set_ordered_item, only: [:update, :destroy]
  
  def create
    @cart.add_product(params)
    if @cart.save
      render partial: 'carts/shopping_bag', locals: { order: @cart }
    else
      flash[:error] = 'There was a problem adding this item to your shopping bag.'
      redirect :back
    end
  end

  # update quantity
  def update
    @ordered_item.update(quantity: params[:quantity]) if @ordered_item
    if @ordered_item.save
      flash[:message] = "Your shopping bag has been updated."
      render json: { itemPrice: @ordered_item.quantity * @ordered_item.product.price, subtotal: @cart.total_price  }
    else
      flash[:error] = 'There was a problem updating your shopping bag'
      redirect :back
    end
  end

  def destroy
    @ordered_item.destroy
    render json: { order_total: "$%.2f" % @cart.total_price }
  end

  private 

    def set_ordered_item
      @ordered_item = @cart.ordered_items.find_by(id: params[:item_id])
    end
end
