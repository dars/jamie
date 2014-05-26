module DevicesHelper
  def device_status_label(status)
    if status == 1
      return raw('<span class="label label-primary">正常</span>')
    else
      return raw('<span class="label label-default">停用</span>')
    end
  end

  def show_dealer(device)
    if device.demo
      return raw("<span class='label label-info'>公關用機</span>")
    else
      unless device.dealer.nil?
        return raw("<span class='label label-inverse'>"+device.dealer.name+"</span>")
      end
    end
  end
end
