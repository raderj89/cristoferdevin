class Image < ActiveRecord::Base
  # Relations
  belongs_to :product

  #Paperclip
  has_attached_file :image_url, :styles => {:medium => "300x300>", :thumb => "100x100>"}
  validates_attachment_content_type :image_url, :content_type => /\Aimage\/.*\Z/
end
