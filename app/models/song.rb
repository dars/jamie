class Song < ActiveRecord::Base
  self.table_name = 'songtable'
  belongs_to :singer1, class_name: 'Singer', primary_key: 'ID', foreign_key: 'SingerIndex1'
  belongs_to :singer2, class_name: 'Singer', primary_key: 'ID', foreign_key: 'SingerIndex2'
  belongs_to :phylum, class_name: 'Phylum', foreign_key: 'Phylum'

  def human_song_number
    return [self.SongNumber.to_i].pack('l').unpack('H*')[0].scan(/[0-9a-z]{2}/i).reverse.join[3..10]

    # return [(self.SongNumber).scan(/[0-9a-f]{2}/i).reverse.join].pack('H*').unpack('l')
  end
end
