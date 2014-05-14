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
      set_flash 'success', '登入成功'
      redirect_to devices_path
    else
      set_flash 'danger', '登入失敗，請確認您的資料', true
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end
end
