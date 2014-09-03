class AddCartIdToOrderedItems < ActiveRecord::Migration
  def change
    add_reference :ordered_items, :cart, index: true
  end
end
