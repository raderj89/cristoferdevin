class CategoriesProduct < ActiveRecord::Base

  # Relations
  belongs_to :category
  belongs_to :product

end
