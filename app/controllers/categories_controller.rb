class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  def index
    @categories = Category.all
    @category = Category.new
  end

  def show
    @recipes = @category.recipes
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = current_user.categories.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { redirect_to root_url, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_url, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :description, :user_id)
    end
end
