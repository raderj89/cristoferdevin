class CartsController < ApplicationController
  inherit_resources
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  private

    def set_cart
      @cart = Cart.find(session[:cart_id])
    end

    def invalid_cart
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to root_url, notice: "Invalid cart"
    end

end