class StoreChain < ActiveRecord::Base
  has_many :stores
  has_many :flyers
end
