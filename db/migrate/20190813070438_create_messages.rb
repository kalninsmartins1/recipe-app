# Migration for creating messages table
class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :chef_id
      t.timestamps
    end
  end
end
