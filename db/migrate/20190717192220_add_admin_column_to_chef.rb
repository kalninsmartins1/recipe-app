# Migration for adding admin column to chefs table
class AddAdminColumnToChef < ActiveRecord::Migration[5.2]
  def change
    add_column :chefs, :admin, :boolean
  end
end
