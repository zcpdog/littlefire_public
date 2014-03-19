class CategoriesController < ApplicationController
  before_filter :find_model, :only => [:show]

  def index
    @categories = Category.includes(:children).where(parent_id: nil)
  end
  
  def show
    @deals = @category.includes(:children).deals.page(params[:page])
    respond_to do |wants|
      wants.html # show.html.erb
    end
  end
  
  private
    def find_model
      @category = Category.find(params[:id])
    end

end

