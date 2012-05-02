module ApplicationHelper
 # Return a title on a per-page basis.
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  def logo
    if cookies.signed[:gender] && cookies.signed[:gender] == "Naiset"
      image_tag("logo_black.png", :alt => "Suit up", :class => "round")
    else
      image_tag("logo_white.png", :alt => "Suit up", :class => "round")
    end
  end
end
