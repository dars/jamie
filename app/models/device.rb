class Device < ActiveRecord::Base
  self.table_name = 'Device'
  self.primary_key = 'ID'
  belongs_to :dealer, :class_name => 'User', :foreign_key => 'dealer_id'
  belongs_to :lease, :foreign_key => 'ID', :primary_key => 'device_id'
end
