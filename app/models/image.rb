class Image < ActiveRecord::Base
  # Relations
  belongs_to :product

  attr_reader :image_url_remote_url

  #Paperclip
  has_attached_file :image_url, :styles => {:medium => "300x300>", :thumb => "100x100>"}
  validates_attachment_content_type :image_url, :content_type => /\Aimage\/.*\Z/

  def image_url_remote_url=(url_value)
    self.image_url = URI.parse(url_value)
    @image_url_remote_url = url_value
  end
end
