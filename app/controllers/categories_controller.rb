class CategoriesController < ApplicationController
  #before_filter :find_model, :only => [:show, :edit, :update, :destroy]

  # GET /models
  # GET /models.xml
  def index
    @categories = Category.all
    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @categories }
    end
  end

  # GET /models/1
  # GET /models/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @category }
    end
  end

  # GET /models/new
  # GET /models/new.xml
  def new
    @category = Category.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @category }
    end
  end

  # GET /models/1/edit
  def edit
    @category = Category.find(params[:id])
    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @category }
    end
  end

  # POST /models
  # POST /models.xml
  def create
    @category = Category.new(params[:model])

    respond_to do |wants|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        wants.html { redirect_to(@category) }
        wants.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /models/1
  # PUT /models/1.xml
  def update
    respond_to do |wants|
      if @category.update_attributes(params[:model])
        flash[:notice] = 'Category was successfully updated.'
        wants.html { redirect_to(@category) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1
  # DELETE /models/1.xml
  def destroy
    @category.destroy

    respond_to do |wants|
      wants.html { redirect_to(models_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_model
      @category = Category.find(params[:id])
    end

end

