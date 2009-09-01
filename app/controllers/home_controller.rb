class HomeController < ApplicationController
  caches_page :index

  def index
    @articles = Article.find_published(10)
    @article = @articles.delete_at 0
  end
end
