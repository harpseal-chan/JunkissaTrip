module ApplicationHelper
  def full_title(page_title = '')
    base_title = "純喫茶Trip"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def exist_search_bar?
    return true if (controller_name == 'static_pages') && (action_name == 'home')
    return true if (controller_name == 'shops') && (action_name == 'index')

    false
  end

  def maps_path?
    return true if (controller_name == 'maps') && (action_name == 'search')
    false
  end
end
