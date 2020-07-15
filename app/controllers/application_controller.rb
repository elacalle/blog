class ApplicationController < ActionController::Base
  def is_logged_in?
    redirect_to root_path if helpers.current_user.nil?
  end
end
