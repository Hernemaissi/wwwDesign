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
    @results = Ad.in_categories(@categories).available(true).paginate :page => params[:page], :per_page => 3 
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
    
    @categories = Category.find_all_by_id(params[:categories])

    @results = Ad.in_categories(params[:categories])
    
    
    if(params[:available] == "true")
      @results = @results.available(true)
    end
    
   if(!params[:price_lower].empty? && !params[:price_higher].empty?)
      @results = @results.price_between(params[:price_lower], params[:price_higher])
   elsif (!params[:price_higher].empty?)
      @results = @results.price_lower(params[:price_higher])
   elsif(!params[:price_lower].empty?)
      @results = @results.price_higher(params[:price_lower])
   end
   
   if (!params[:condition].empty?)
     @results = @results.in_condition(params[:condition])
   end
   
   if (!params[:color].empty?)
     @results = @results.in_color(params[:color])
   end
   
   #TONIIIIIII ;_______________;
   #@results = @results.with_parts(params[:parts][0]) <- toimii
   #@results = @results.with_parts(params[:parts][1]) <- ei enää toimi
   
   @results = @results.paginate :page => params[:page], :per_page => 3 
    respond_to do |format|
      format.html { 
        render :partial => 'search/results', :locals => {:results => @results} }
    end
  end


  
end