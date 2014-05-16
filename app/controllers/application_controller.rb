class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionHelper
  def set_flash(type, message, now = false)
    if(now)
      flash.now[:notice] = {:type => type, :message => message}
    else
      flash[:notice] = {:type => type, :message => message}
    end
  end
end