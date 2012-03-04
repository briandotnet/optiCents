class AddStoreChainIdToItems < ActiveRecord::Migration
  def self.up
    add_column :items,:store_chain_id, :integer
    add_column :items,:category, :string
    remove_column :items, :quantity
    add_column :items, :quantity, :string
  end

  def self.down
    remove_column :items,:store_chain_id
    remove_column :items,:category
    remove_column :items, :quantity
    add_column :items, :quantity, :integer
  end
end
