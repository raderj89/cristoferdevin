class Admin::ImagesController < Admin::ApplicationController
  inherit_resources
  before_action :require_admin_signin!
  layout "admin"
  
  def destroy
    @product = Image.find_by(id: params[:id]).product
    destroy! { edit_admin_product_path(@product)}
  end
end