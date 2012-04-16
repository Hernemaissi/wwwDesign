class PagesController < ApplicationController
  def home
    @title = "Home"
    @categories = Category.all
    @category = Category
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end

end
