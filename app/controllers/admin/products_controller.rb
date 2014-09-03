class Admin::ProductsController < Admin::ApplicationController
  inherit_resources
  before_action :require_admin_signin!
  before_action :set_product, only: [:edit, :update]
  before_action :load_categories, only: [:new, :edit]
  layout "admin"

  def index
    if params[:category]
      @category = Category.find_by(title: params[:category])
      @products = @category.products.paginate(page: params[:page], per_page: 15)
      @featured_product = @category.featured
    else
      @products = Product.paginate(page: params[:page], per_page: 15)
    end
  end

  def new
    @product = Product.new
    @categories_product = @product.categories_products.build
  end

  def create
    @product = Product.new(product_params)
    if params[:product][:upload_image]
      @product.images.create(image_url: params[:product][:upload_image])
    end
    if @product.save
      params[:product][:categories_product][:category].each do |id|
        @category = Category.find_by(id: id)
        next if @category.nil?
        @category.categories_products.create(product_id: @product.id)
      end
      redirect_to admin_product_path(@product)
    else
      flash[:error] = "Something went wrong, please try again."
      redirect_to :back
    end
  end

  def edit
    @categories_product = @product.categories_products.first
    @image = Image.new
    super
  end

  def update
    if params[:product][:upload_image]
      @product.images.create(image_url: params[:product][:upload_image])
    end
    update! { edit_admin_product_path(@product) }
    # build categories products:
    params[:product][:category][:category].each do |id|
     @category = Category.find_by(id: id) 
     next if @category.nil?
     @category.categories_products.create(product_id: @product.id)
   end
  end

  def feature
    @product = Product.find_by(id: params[:id])
    @category = Category.find_by(id: params[:category][:id])
    @fp = FeaturedProduct.new(product_id: @product.id, category_id: @category.id)
    if @fp.save
      flash[:message] = "Please add a title and description to your featured product."
      redirect_to edit_admin_featured_product_path(@fp)
    else
      flash[:error] = "Something Went Wrong"
      render nothing: true
    end
  end

  private

    def set_product
      @product = Product.find_by(slug: params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :price, :gem_type, :length, :karat, :images_attributes)
    end

    def load_categories
      @categories = Category.all
    end

end