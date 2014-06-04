class SessionController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:destroy]
  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if(@user && @user.authenticate(params[:session][:password]))
      sign_in(@user)
      # session[:session_token] = @user.session_token
      @user.last_sign_in_ip = request.remote_ip
      @user.last_sign_in_at = Time.now
      @user.sign_in_count = @user.sign_in_count+1
      @user.save

      case (@user.role)
        when 'admin'
          redirect_to devices_path, :notice => '登入成功'
        when 'staff'
          redirect_to devices_path, :notice => '登入成功'
        when 'dealer'
          redirect_to devices_device_report_path, :notice => '登入成功'
        when 'licensees'
          redirect_to playlog_index_path, :notice => '登入成功'
      end
    else
      flash.now[:alert] = '登入失敗，請確認您的資料'
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to login_path, :notice => '您已登出'
  end
end
