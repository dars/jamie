class Singer < ActiveRecord::Base
  self.table_name = 'SingerTable'
  self.primary_key = 'ID'
  belongs_to :country, :foreign_key => 'Country'
  belongs_to :kind, :foreign_key => 'Class'
end
