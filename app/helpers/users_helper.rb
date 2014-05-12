module UsersHelper
  def status_label(status)
    if status
      return raw('<span class="label label-primary">正常</span>')
    else
      return raw('<span class="label label-default">停權</span>')
    end
  end

  def role_label(role)
    if role == 'admin'
      return raw('<span class="label label-info">Admin</span>')
    else
      return raw('<span class="label label-inverse">User</span>')
    end
  end
end
