module ApplicationHelper
  def full_title page_title = ""
    base_title = t "title_full"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end
end
