class ArticlesController < ApplicationController
  before_filter :auth_required, :except => [:index, :show, :comment]
  before_filter :load_article, :only => [:show, :edit, :update, :destroy, :comment]
  
  # GET /articles
  # GET /articles.xml
  def index
    @page_title = "Articles"
    respond_to do |format|
      format.html do # index.html.erb
        @articles = Article.find_published
      end
      format.rss  do # index.rss.erb
        @articles = Article.find_published(10)
      end
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @page_title = @article.title
    @permalink = url_for(@article)
    @comment = @article.comments.new
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        flash[:notice] = 'Article was successfully created.'
        format.html { redirect_to(@article) }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    respond_to do |format|
      if @article.update_attributes(params[:article])
        flash[:notice] = 'Article was successfully updated.'
        format.html { redirect_to(@article) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end

  # POST /articles/id/comment
  # POST /articles/id/comment.xml
  def comment
    # TODO should not be setting this in controller
    @page_title = @article.title
    @comment = @article.comments.new(params[:comment])
    @comment.is_author = authorized?
    
    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to(@article) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
protected
  def load_article
    @article = Article.find(params[:id])
  end
end
