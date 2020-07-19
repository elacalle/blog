class SessionsController < ApplicationController
  before_action :access_login, only: [:new]

  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])

    if @user && @user.valid_password?(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notification] = { type: :success, messages: [I18n.t('sessions.create.success_login')] }

      redirect_to root_path
    else
      flash[:notification] = { type: :warning, messages: [I18n.t('sessions.new.failed_login')] }

      redirect_to login_path
    end
  end

  def destroy
    if helpers.current_user
      reset_session
      flash[:notification] = {
        type: :success,
        messages: [I18n.t('sessions.destroy.success_logout')],
      }

      redirect_to root_path
    end
  end

  private

  def access_login
    redirect_to root_path if helpers.current_user
  end
end
