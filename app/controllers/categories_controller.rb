class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    if Category.find_by(title: category_params[:title]) 
      flash.notice = "Sorry, the category name #{category_params[:title]} already exists!"
      redirect_to new_category_path
    else
      @category = Category.create!(category_params)
      redirect_to jobs_path(category: @category.title)
    end
  end 

  def destroy
    category = Category.find(params[:id])
    category.jobs.destroy
    category.destroy
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end
end
