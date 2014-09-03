class FeaturedProduct < ActiveRecord::Base
  # Relations
  belongs_to :product
  belongs_to :category

  # Validations
  validates_presence_of :title, :description, :product_id, :category_id
  validates :title, length: { maximum: 100, minimum: 3 }
  validates :description, length: { maximum: 100, minimum: 25 }
end
