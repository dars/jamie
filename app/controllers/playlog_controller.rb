class PlaylogController < ApplicationController
  before_action :is_signed?
  before_action :check_role
  layout 'main'

  def index
    @base = (130.00/Time.days_in_month(Time.new.month)).round(1)
    time = Time.new
    range = "#{time.year}-#{sprintf("%02d", time.month)}-%"
    if current_user.role == 'licensees'
      songs = Song.select('SongNumber').where('licensee_id=?', current_user.id)
      ids = []
      songs.each do |i|
        ids.push(i['SongNumber'])
      end
      @items = Playlog.select('songNumberID, COUNT(id) as count').where("datetime LIKE ?", range).where(:SongNumberID => ids).group('songNumberID').order('COUNT(id) DESC')
    else
      @items = Playlog.select('songNumberID, COUNT(id) as count').where("datetime LIKE ?", range).group('songNumberID').order('COUNT(id) DESC')
    end
  end
end
