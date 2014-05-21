class Device < ActiveRecord::Base
  self.table_name = 'Device'
  self.primary_key = 'ID'
  belongs_to :dealer
  has_many :transations
end
