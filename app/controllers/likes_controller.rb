class LikesController < ApplicationController
  before_action :set_recipe

  def toggle_like
    if(@like = @recipe.likes.find_by(user: current_user))
      @like.destroy
    else
      @recipe.likes.create(user: current_user)
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "recipe#{@recipe.id}actions",
          partial: "recipes/recipe_actions",
          locals: {recipe: @recipe}
        )
      end
    end
  end

  private
  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end