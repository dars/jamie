class Transaction < ActiveRecord::Base
  self.inheritance_column = nil
  belongs_to :device, foreign_key: 'device_id'
end
