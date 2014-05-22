class PricesController < ApplicationController
  layout 'main'

  def index
    # 取得當前日期
    d = Date.today
    @licensees = Licensee.all
    @play_times_ar = []
    @licensees.each do |l|
      @play_times_ar[l.id] = 0
    end

    # 該月總天數
    @base_days = Time.days_in_month(d.month)

    # 當月基數
    @base = (130.00/@base_days).round(1)

    # 當月點唱記錄
    date_str = d.year.to_s+'-'+d.strftime('%m')+'-%'
    @times = Playlog.where("datetime Like ?", date_str)

    # 計算每家版權商點撥次數
    @times.each do |t|
      if (@play_times_ar[t.song.licensee_id])
        @play_times_ar[t.song.licensee_id] += 1
      end
    end

    # 全部的機器
    @devices = Device.all

    # 計算每台機器的貢獻度
    @total_price_tmp = 0
    @total_count = 0
    @devices.each do |device|
      days = alive_days device.ID, d
      if (days > 0)
        @total_price_tmp += days*@base
        # 該月有貢獻機器
        @total_count += 1
      end
    end

    # 總金額無條件捨去小數位
    @total_price = @total_price_tmp.floor

    # 每次點撥可得
    @unit_price = @total_price/@times.count

  end
end