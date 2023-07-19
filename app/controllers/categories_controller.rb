class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories or /categories.json
  def index
  end

  # GET /categories/1 or /categories/1.json
  def show
    @recipes = @category.recipes
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  #   def create
  #   @category = current_user.categories.new(category_params)

  #   respond_to do |format|
  #     if @category.save
  #       format.turbo_stream do
  #         render turbo_stream: [
  #           turbo_stream.update('new_category',
  #                               partial: 'categories/form',
  #                               locals: { category: @category }),
  #           turbo_stream.prepend('categories',
  #                                partial: 'categories/categories',
  #                                locals: { category: @category })
  #         ]
  #       end
  #       format.html { redirect_to categories_url, notice: 'Category was successfully created.' }
  #     else
  #       format.html { redirect_to root_url, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # POST /categories or /categories.json
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

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_url(@category), notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :description, :user_id)
    end
end
