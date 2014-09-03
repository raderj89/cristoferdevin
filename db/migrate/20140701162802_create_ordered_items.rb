class CreateOrderedItems < ActiveRecord::Migration
  def change
    create_table :ordered_items do |t|
      t.references :product, index: true
      t.references :order, index: true
      t.integer :quantity, default: 1
      t.decimal :unit_price_at_order, precision: 8, scale: 2

      t.timestamps
    end
  end
end
