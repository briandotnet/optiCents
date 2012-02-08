class CreateSales < ActiveRecord::Migration
  def self.up
    create_table :sales do |t|
      t.integer :item_id
      t.integer :sale_type_id
      t.integer :flyer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sales
  end
end
