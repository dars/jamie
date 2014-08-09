module UsersHelper
  def status_label(status)
    if status
      return raw('<span class="label label-primary">正常</span>')
    else
      return raw('<span class="label label-default">停權</span>')
    end
  end

  def role_label(role, user)
    if role == 'admin'
      return raw('<span class="label label-info">Admin</span>')
    elsif role == 'staff'
      return raw('<span class="label label-success">工作人員</span>')
    elsif role == 'dealer'
      return raw('<span class="label label-primary">經銷商</span>')
    else
      return raw('<span class="label label-inverse">版權商</span>')
    end
  end
end
