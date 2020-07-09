module ApplicationHelper
  def site_title(title)
    title ||= 'My Blog'
    title = "#{title} | A normal blog site"
    title
  end

  def current_user
    if session[:user_id]
      user ||= User.find(session[:user_id])
    end

    user
  end
end
