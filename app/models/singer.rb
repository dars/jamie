class Singer < ActiveRecord::Base
  self.table_name = 'SingerTable'
  self.primary_key = 'ID'
end
