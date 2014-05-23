module ApplicationHelper
  def trans_song_number(number)
    return [number.to_i].pack('l').unpack('H*')[0].scan(/[0-9a-z]{2}/i).reverse.join.delete('f')
  end
end
