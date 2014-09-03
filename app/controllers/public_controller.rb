class PublicController < ApplicationController
  include CurrentOrder
  before_action :get_cart
  
  def index
    @categories = Category.by_position
    @cover = Category.find_by(position: 1)
    @featured_products = FeaturedProduct.all
  end

  def about
  end

  def tos
  end

  def faq
  end

  def contact
  end

  def privacy
  end
end