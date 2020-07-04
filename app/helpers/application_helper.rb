module ApplicationHelper
  def site_title(title)
    title ||= 'My Blog'
    title = "#{title} | A normal blog site"
    title
  end
end
