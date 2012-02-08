class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.string :brand
      t.integer :quantity
      t.text :description
      t.float :regular_price

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
