class ArticlesController < ApplicationController
  def index
    @article_type = ArticleType.find_by(code: params[:article_type_code]||"tutorial")
    @articles = Article.active.type_of(@article_type).page params[:page]
  end
  
  def show
    @article = Article.active.find params[:id]
  end
end
