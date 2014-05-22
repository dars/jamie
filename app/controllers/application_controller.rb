class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :getHotSongs
  protect_from_forgery with: :exception
  include SessionHelper
  def set_flash(type, message, now = false)
    if(now)
      flash.now[:notice] = {:type => type, :message => message}
    else
      flash[:notice] = {:type => type, :message => message}
    end
  end

  def getHotSongs
    @hots = Playlog.group('SongNumberID').order('count(id) DESC').limit(5)
  end

  # 計算機器該月貢獻天數
  # target_date = '2014-05-21'
  def alive_days (device_id, target_date)
    s_date = target_date.year.to_s+'-'+target_date.month.to_s+'-01'
    e_date = target_date.year.to_s+'-'+target_date.month.to_s+'-'+Time.days_in_month(target_date.month).to_s
    @transaction = Transation.where('device_id=?', device_id).where('(? between start_date and end_date) or (? between start_date and end_date)', s_date, e_date).first
    if(@transaction)
      if (@transaction.start_date < Date.new(target_date.year, target_date.month, 1))
        @date1 = Date.new(target_date.year, target_date.month, 1)
      else
        @date1 = @transaction.start_date
      end
      if (target_date > @transaction.end_date)
        @date2 = @transaction.end_date
      else
        @date2 = target_date
      end
    else
      return -1
    end
    return (@date2 - @date1 + 1).to_i
  end
end
