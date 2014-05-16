module DevicesHelper
  def device_status_label(status)
    if status == 1
      return raw('<span class="label label-primary">正常</span>')
    else
      return raw('<span class="label label-default">停用</span>')
    end
  end
end
