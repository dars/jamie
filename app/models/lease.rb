class Lease < ActiveRecord::Base
  has_one :device, :foreign_key => 'ID', :primary_key => 'device_id'
end
