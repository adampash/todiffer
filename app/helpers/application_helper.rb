module ApplicationHelper
  def header_link
    if user_signed_in?
      link_to "To Differ", texts_path
    else
      link_to "To Differ", root
    end
  end
end
