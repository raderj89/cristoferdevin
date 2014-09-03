class CategoriesController < ApplicationController
  inherit_resources
  before_action :set_category, only: :show

  private

    def set_category
      @category = Category.find_by(title: params[:title])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "We couldn't find a category by that name."
      redirect_to root_url
    end

end