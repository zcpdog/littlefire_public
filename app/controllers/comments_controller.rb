class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create]
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment].permit(:content,:deal_id))
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.js {render :partial => 'comment', :locals => { :comment => @comment }}
      end
    end
  end
  
  private
    def find_commentable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
end