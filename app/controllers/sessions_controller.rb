class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])

    if @user && @user.valid_password?(params[:session][:password])
      session[:user_id] = @user.id

      redirect_to root_path
    else
      flash[:warning] = [I18n.t('sessions.new.failed_login')]

      redirect_to login_path
    end
  end
end
