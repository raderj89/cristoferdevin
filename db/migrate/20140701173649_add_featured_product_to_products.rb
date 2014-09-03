class AddFeaturedProductToProducts < ActiveRecord::Migration
  def change
    add_column :products, :featured, :boolean, default: false
    add_column :products, :gem_type, :string
    add_column :products, :length, :integer
    add_column :products, :karat, :integer
  end
end
