class Store < ActiveRecord::Base
  belongs_to :store_chain
  acts_as_mappable  :defanlt_units => :kms,
                    :lat_column_name => :lat,
                    :lng_column_name => :lng
end
