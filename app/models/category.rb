class Category < ActiveRecord::Base

  # Relations
  has_many :categories_products
  has_many :products, through: :categories_products
  has_one :featured_product, dependent: :destroy

  # Validations
  validates_presence_of :title, :header, :subheader, :image
  validates :title, length: { maximum: 100, minimum: 3 }
  validates :header, length: { maximum: 100, minimum: 3 }
  validates :subheader, length: { maximum: 100, minimum: 5 }

  #Paperclip
  # has_attached_file :image_url, :styles => {:medium => "300x300>", :thumb => "100x100>"}
  # validates_attachment_content_type :image_url, :content_type => /\Aimage\/.*\Z/

  # Behavior
  acts_as_list

  #Scopes
  scope :by_position, -> { order("position ASC") }

  # Methods
  def featured
    self.featured_product
  end
end
