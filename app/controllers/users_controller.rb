class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      flash[:notification] = { type: :success, messages: [I18n.t('users.create.success')] }

      redirect_to signup_path
    else
      errors = @user.errors.full_messages.flatten
      flash[:notification] = { type: :warning, messages: errors }

      redirect_to signup_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
