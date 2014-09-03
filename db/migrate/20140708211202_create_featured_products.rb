class CreateFeaturedProducts < ActiveRecord::Migration
  def change
    create_table :featured_products do |t|
      t.string :title
      t.string :description
      t.references :product, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
