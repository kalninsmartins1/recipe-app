# Renaming Chefs table name column
class RenameChefNameColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :chefs, :chef_name, :name
  end
end
