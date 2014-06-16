class Transaction < ActiveRecord::Base
  has_soft_deletion :default_scope => true
  self.inheritance_column = nil
  belongs_to :lease, foreign_key: 'lease_id'
end
