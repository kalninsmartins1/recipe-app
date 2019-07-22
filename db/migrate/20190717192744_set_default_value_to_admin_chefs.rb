class SetDefaultValueToAdminChefs < ActiveRecord::Migration[5.2]
  def change
    change_column :chefs, :admin, :boolean, default: false
  end
end
