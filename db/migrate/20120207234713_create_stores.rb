class CreateStores < ActiveRecord::Migration
  def self.up
    create_table :stores do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :province
      t.string :postal_code
      t.string :phone
      t.string :description
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end

  def self.down
    drop_table :stores
  end
end
