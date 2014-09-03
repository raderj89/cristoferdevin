class AddBillingToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :billing_first_name, :string
    add_column :orders, :billing_last_name, :string
    add_column :orders, :billing_address, :string
    add_column :orders, :billing_address2, :string
    add_column :orders, :billing_city, :string
    add_column :orders, :billing_state, :string
    add_column :orders, :billing_zip, :string
    add_column :orders, :billing_email, :string
    add_column :orders, :billing_phone, :string
  end
end
