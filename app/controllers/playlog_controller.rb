class PlaylogController < ApplicationController
  layout 'main'
  def index
    @base = (130.00/Time.days_in_month(Time.new.month)).round(1)
    @items = Playlog.select('songNumberID, COUNT(id) as count').group('songNumberID').order('COUNT(id) DESC')
  end
end
