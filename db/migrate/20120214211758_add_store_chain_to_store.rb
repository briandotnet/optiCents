class AddStoreChainToStore < ActiveRecord::Migration
  def self.up
    add_column :stores,:store_chain_id, :integer
    remove_column :flyers, :store_id
    add_column :flyers, :store_chain_id, :integer
  end

  def self.down
    remove_column :stores, :store_chain_id
    remove_column :flyers, :store_chain_id
    add_column :flyers, :store_id, :integer
  end
end
