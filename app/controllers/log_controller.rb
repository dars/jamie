class LogController < ApplicationController
  layout 'main'
  before_action :is_signed?

  def index
    @logs = Log.all.order('DateTime Desc').page(params[:page])
  end

  def songRecord
    @logs = Log.select('count(ID) as count, SongNumber').where('CmdType=?', 145).group('SongNumber').order('count desc').page(params[:page])
  end
end
