class AddImageUrlColumnToImages < ActiveRecord::Migration
  def self.up
    add_attachment :images, :image_url
  end

  def self.down
    remove_attachment :images, :image_url
  end
end
