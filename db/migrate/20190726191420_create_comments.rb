# Migration for creating comments table
class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :description
      t.integer :recipe_id
      t.integer :chef_id
    end
  end
end
