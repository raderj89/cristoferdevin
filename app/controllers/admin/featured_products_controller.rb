class Admin::FeaturedProductsController < Admin::ApplicationController
  inherit_resources
  layout "admin"

  private

    def featured_product_params
      params.require(:featured_product).permit(:title, :description)
    end
end