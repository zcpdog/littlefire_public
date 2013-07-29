class DealsController < ApplicationController
  layout "welcome"
  before_filter :find_model, :only => [:show, :edit, :update, :destroy]
  # GET /models
  # GET /models.xml
  def index
    @deals = Deal.all.paginate(page: params[:page], per_page: 20).order('id DESC')
    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @deals }
    end
  end

  # GET /models/1
  # GET /models/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @deal }
    end
  end

  # GET /models/new
  # GET /models/new.xml
  def new
    @deal = Deal.new
    @deal.pictures.build
    @deal.pictures.build
    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @deal }
    end
  end

  # GET /models/1/edit
  def edit
  end

  # POST /models
  # POST /models.xml
  def create
    @deal = Deal.new(deal_params)

    respond_to do |wants|
      if @deal.save
        flash[:notice] = 'Deal was successfully created.'
        wants.html { redirect_to(@deal) }
        wants.xml  { render :xml => @deal, :status => :created, :location => @deal }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @deal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /models/1
  # PUT /models/1.xml
  def update
    respond_to do |wants|
      if @deal.update_attributes(deal_params)
        flash[:notice] = 'Deal was successfully updated.'
        wants.html { redirect_to(@deal) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @deal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1
  # DELETE /models/1.xml
  def destroy
    @deal = Deal.find(params[:deal])
    @deal.destroy
    respond_to do |wants|
      wants.html { redirect_to(deals_path) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_model
      @deal = Deal.find(params[:id])
    end
    
    def deal_params
      params.require(:deal).permit(:user, :merchant_id,:category_id,:title,:reason,
      :location,:due_date,:amazing_price, pictures_attributes: :image)
      
    end

end

