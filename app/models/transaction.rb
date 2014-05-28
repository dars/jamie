class Transaction < ActiveRecord::Base
  has_soft_deletion :default_scope => true
  self.inheritance_column = nil
  belongs_to :device, foreign_key: 'device_id'
end
