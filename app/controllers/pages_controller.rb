class PagesController < ApplicationController
  def home
    @title = "Etusivu"
    if cookies.signed[:gender] && cookies.signed[:gender] == "Naiset"
      @categories = Category.find_by_name("Naiset").children
    else
      @categories = Category.find_by_name("Miehet").children
    end
    @category = Category
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end

end
