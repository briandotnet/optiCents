class CreateStoreChains < ActiveRecord::Migration
  def self.up
    create_table :store_chains do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :store_chains
  end
end
