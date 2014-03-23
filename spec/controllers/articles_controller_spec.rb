require 'spec_helper'

describe ArticlesController do
  it "should fill content_plain_text before save"  do
    article_type = ArticleType.create(name: "tutorial", code: "tutorial",description: "a tutorial")
    article = Article.create(title: "this is a test ", content: "<p>this is a test</p>", article_type_id: article_type.id)
    article.should be_a_new(Article)
  end
end
