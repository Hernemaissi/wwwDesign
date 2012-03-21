class PagesController < ApplicationController
  def home
    @title = "Home"
    @ads = Ad.all
    @category = Category
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end

end
