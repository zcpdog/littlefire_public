class MerchantsController < ApplicationController
  before_filter :find_merchant, :only => [:show, :edit, :update, :destroy]

  # GET /models
  # GET /models.xml
  def index
    @merchants = Merchant.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @merchants }
    end
  end

  # GET /models/1
  # GET /models/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @merchant }
    end
  end

  # GET /models/new
  # GET /models/new.xml
  def new
    @merchant = Merchant.new
    @merchant.build_picture
    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @merchant }
    end
  end

  # GET /models/1/edit
  def edit
    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @merchant }
    end
  end

  # POST /models
  # POST /models.xml
  def create
    @merchant = Merchant.new merchant_params

    respond_to do |wants|
      if @merchant.save
        flash[:notice] = 'Merchant was successfully created.'
        wants.html { redirect_to(@merchant) }
        wants.xml  { render :xml => @merchant, :status => :created, :location => @merchant }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @merchant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /models/1
  # PUT /models/1.xml
  def update
    respond_to do |wants|
      if @merchant.update_attributes(merchant_params)
        flash[:notice] = 'Merchant was successfully updated.'
        wants.html { redirect_to(@merchant) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @merchant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1
  # DELETE /models/1.xml
  def destroy
    @merchant.destroy
    respond_to do |wants|
      wants.html { redirect_to(merchants_path) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_merchant
      @merchant = Merchant.find(params[:id])
    end
    
    def merchant_params
      params.require(:merchant).permit(:name, :url, picture_attributes: :image)
    end

end

