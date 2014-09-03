class Admin::CategoriesController < Admin::ApplicationController
  layout "admin"
  inherit_resources
  before_action :require_admin_signin!

  def index
    @categories = Category.by_position
  end

  def sort
    params[:category].each_with_index do |id, index|
      category = Category.find_by(id: id)
      category.update(position: index + 1)
    end
    render nothing: true
  end

  private

    def category_params
      params.require(:category).permit(:title, :header, :subheader)
    end

end
