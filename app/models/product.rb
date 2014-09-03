class Product < ActiveRecord::Base
  # Friendly ID for pretty URLs
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  # Relations
  has_many :categories_products
  has_many :categories, through: :categories_products
  has_many :images, dependent: :destroy
  has_many :featured_products, dependent: :destroy
  has_many :ordered_items

  # Nested Attributes
  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :categories_products

  # Callbacks
  before_destroy :ensure_not_referenced_by_any_ordered_item

  # Validations
  validates_presence_of :title, :description
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true, length: { minimum: 2, message: "Please give the product a longer title." }

  # Pagination
  self.per_page = 10

  # Methods

  def is_featured?
    unless self.categories_products.first.category.featured.nil?
      self.id == self.categories_products.first.category.featured.product_id 
    end
  end

  private

    # Ensure there are no ordered items referencing this product
    def ensure_not_referenced_by_any_ordered_item
      if ordered_items.empty?
        return true
      else
        errors.add(:base, "Ordered items present.")
        return false
      end
    end
end
