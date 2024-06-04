class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  def index

   @highights = Article.desc_order.first(3)
   highights_ids = @highights.pluck(:id).join(',')

   @pagy, @articles = pagy(Article.desc_order.without_highlights(highights_ids), items: 2)
   
  end

  def show; end

  def new
    @article = Article.new
  end

  def create
   @article = Article.new(article_params)

    respond_to do |format|
      if@article.save
        format.html { redirect_to article_url(@article), notice: "User was successfully created." }
        format.json { render :show, status: :created, location:@article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json:@article.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to root_path, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def set_article
    @article = Article.find(params[:id])
  end
  
end
