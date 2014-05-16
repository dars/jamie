module SessionHelper
  def sign_in(user)
    session[:session_token] = user.session_token
  end

  def signed_in?
    !current_user.nil?
  end

  def is_signed?
    redirect_to '/login' if (current_user.nil?)
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def current_user?(user)
    current_user == user
  end

  def is_admin?
    is_signed?
    if (current_user.role == 'admin')
      return true
    else
      return false
    end
  end

  def is_staff?
    is_signed?
    if (current_user.role == 'staff')
      return true
    else
      return false
    end
  end

  def is_user?
    is_signed?
    if (current_user.role == 'user')
      return true
    else
      return false
    end
  end

  def sign_out
    @current_user = nil
    session.delete(:session_token);
  end
end
