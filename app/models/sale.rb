class Sale < ActiveRecord::Base
  belongs_to :flyer
  has_one :item
end
