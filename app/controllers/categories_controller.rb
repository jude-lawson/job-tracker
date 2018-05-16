class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create!(category_params)
    redirect_to jobs_path(category: @category_title)
  end

  def show
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end
end