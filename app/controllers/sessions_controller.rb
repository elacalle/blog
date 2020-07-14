class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])

    if @user && @user.valid_password?(params[:session][:password])
      session[:user_id] = @user.id
      flash.now[:success] = [I18n.t('sessions.create.success_login')]

      render 'static/index'
    else
      flash[:warning] = [I18n.t('sessions.new.failed_login')]

      redirect_to login_path
    end
  end

  def destroy
    if helpers.current_user
      reset_session
      flash[:success] = I18n.t('sessions.destroy.success_logout')

      redirect_to root_path
    end
  end
end
