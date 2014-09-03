class ProductsController < ApplicationController
  respond_to :html, :js
  require 'will_paginate/array'

  include CurrentOrder
  before_action :get_cart
  before_action :set_product, only: [:feature, :show]

  def index
    if params[:category]
      @category = Category.find_by(title: params[:category])
      @products = @category.products.paginate(page: params[:page])
      @featured_product = @category.featured
    else
      @products = Product.paginate(page: params[:page])
    end
 
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @ordered_item = OrderedItem.new
  end


  private

    def set_product
      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "We couldn't find that product."
      redirect_to root_url
    end
end