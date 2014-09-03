class AddSubheaderToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :subheader, :string
  end
end
