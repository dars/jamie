module SingersHelper
  def singer_kind (kind)
    case (kind)
      when 1
        res = raw('<span class="label label-primary">男歌星</span>')
      when 2
        res = raw('<span class="label label-danger">女歌星</span>')
      when 3
        res = raw('<span class="label label-inverse">團體</span>')
    end
    return res
  end
end
