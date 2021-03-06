class LogController < ApplicationController
  layout 'main'
  before_action :is_signed?
  before_action :check_role

  def index
    @logs = Log.all.order('DateTime Desc').limit(30)
  end

  def songRecord
    @logs = Log.select('count(ID) as count, SongNumber').where('CmdType=?', 145).group('SongNumber').order('count desc').page(params[:page])
  end

  def update_data
    logs = Log.all.order('DateTime Desc').limit(30)
    output = ''
    logs.each do |log|
      output += "<tr>"
        output += "<td>#{log.DateTime}</td>"
        output += "<td>#{log.RemoteIP}</td>"
        output += "<td>#{log.DeviceSN}</td>"
        output += "<td>#{trans_status log.CmdType}&nbsp;"
        output += "<span class='badge bg-inverse'>#{log.SongNumber}</span>" unless log.SongNumber.nil?
        output += "</td>"
      output += "</tr>"
    end
    render :text => output
  end

  private
  def trans_status(status)
      level = 'default'
      case status
        when 17
          level = 'success'
          str = '設備登入 成功'
        when 18
          level = 'warning'
          str = '設備登入 失敗'
        when 19
          str = '未登入'
        when 33
          str = '傳送該首歌曲'
        when 34
          str = '伺服器上無檔案'
        when 35
          level = 'warning'
          str = '無權限下載檔案'
        when 49
          str = '傳送 Local 資料庫'
        when 51
          str = '傳送跑馬燈資料檔'
        when 65
          str = '傳送公播列表'
        when 67
          str = '傳送公播檔'
        when 81
          str = '傳送背景列表'
        when 83
          str = '傳送背景檔'
        when 97
          str = '傳送過場列表'
        when 99
          str = '傳送過場檔'
        when 113
          str = '傳送更新列表'
        when 115
          str = '傳送更新檔'
        when 4145
          str = '傳送 Online 資料庫'
        when 4129
          str = '傳送該首 Online 歌曲'
        when 145
          level = 'primary'
          str = '伺服器點歌 OK'
        else
          str = '-'
      end
      return "<span class=\"label label-#{level}\">#{str}</span>"
    end
end
