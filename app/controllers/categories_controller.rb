class CategoriesController < ApplicationController
  before_filter :admin_only, :only => [:create, :destroy, :new, :edit, :update, :index, :show]
  def index
    @title = "All Categories"
    @categories = Category.all
  end
  
  def show
    @title = "Temp title"
    @category = Category.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:success] = "New category posted"
      redirect_to categories_url
    else
      @title = "Post new ad"
      render 'new'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "Successfully destroyed category."
    redirect_to categories_url
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = "Successfully updated category."
      redirect_to @category
    else
      render :action => 'edit'
    end
  end

  def new
    @category = Category.new
    @title = "Post new category"
  end
  
  
  def filter_categories
    @categories = Category.subtree_of(params[:id]).arrange

    respond_to do |format|
      format.json { render :json =>  Category.json_tree(@categories)}
    end
  end
  
  def get_parts
    @category = Category.find(params[:id])
    @parts = @category.parts

    respond_to do |format|
      format.json { render :json =>  @parts}
    end
  end
  
end
