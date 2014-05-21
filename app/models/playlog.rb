class Playlog < ActiveRecord::Base
  self.table_name = 'playlog'
  has_one :song, class_name: 'Song', primary_key: 'songNumberID', foreign_key: 'SongNumber'
end
