class SearchController < ApplicationController
  def index
    @title = "Haku"
    
    if cookies.signed[:gender] && cookies.signed[:gender] == "Naiset"
      @categories = Category.find_by_name("Naiset").children
      @current_gender = "Naiset"
    else
      @categories = Category.find_by_name("Miehet").children
      @current_gender = "Miehet"
    end
    @category = Category
   
  end

  def filter_category
    @selected_category = Category.find(params[:id])
    @parts = @selected_category.parts
    respond_to do |format|
      format.html
      format.js
    end
  end

  def filter_parts
    @selected_category = Category.find(params[:id])
    @parts = @selected_category.parts
    respond_to do |format|
      format.html
      format.js
    end
  end
  

  
  def filter
    @data = params[:data]
    @category = Category.find(params[:category])
    @results = @category.ads.available(true)
    
    if(params[:parts])
      params[:parts].each do |id|
        @results.with_part(id)
      end
   end
   
    respond_to do |format|
      #format.html { render :partial => 'categories/categoryads', :locals => {:c => @category} }
      format.html { render :partial => 'search/results', :locals => {:results => @results} }
    end
  end


  
end