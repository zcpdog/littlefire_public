class CommentsController < ApplicationController
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment].permit(:content, :user_id, :deal_id))
    respond_to do |format|
      if @comment.save
        format.js {
          render :partial => 'comment', :locals => { :comment => @comment }
        }
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