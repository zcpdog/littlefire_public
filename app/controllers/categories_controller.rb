class CategoriesController < ApplicationController
  before_filter :find_model, :only => [:show]

  def index
    @categories = Category.all
    respond_to do |wants|
      wants.html # index.html.erb
    end
  end
  
  def show
    @deals = @category.deals.page params[:page] 
    respond_to do |wants|
      wants.html # show.html.erb
    end
  end
  
  private
    def find_model
      @category = Category.find(params[:id])
    end

end

