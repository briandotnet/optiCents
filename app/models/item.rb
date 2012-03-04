class Item < ActiveRecord::Base
  belongs_to :store_chain
  def store_chain_name
    return self.store_chain.name
  end
end
