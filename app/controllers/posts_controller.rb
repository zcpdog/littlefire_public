class PostsController < ApplicationController
  before_filter :find_post, :only => [:show]

  # GET /posts
  def index
    @posts = Post.page
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /posts/1
  def show
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  # 
  # # GET /posts/new
  # # GET /posts/new.xml
  # def new
  #   @post = Post.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #   end
  # end
  # 
  # # GET /posts/1/edit
  # def edit
  # end
  # 
  # # POST /posts
  # # POST /posts.xml
  # def create
  #   @post = Post.new(params[:post])
  # 
  #   respond_to do |format|
  #     if @post.save
  #       flash[:notice] = 'Post was successfully created.'
  #       format.html { redirect_to(@post) }
  #       format.xml  { render :xml => @post, :status => :created, :location => @post }
  #     else
  #       format.html { render :action => "new" }
  #       format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  # 
  # # PUT /posts/1
  # # PUT /posts/1.xml
  # def update
  #   respond_to do |format|
  #     if @post.update_attributes(params[:post])
  #       flash[:notice] = 'Post was successfully updated.'
  #       format.html { redirect_to(@post) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  private
    def find_post
      @post = Post.find(params[:id])
    end
end
