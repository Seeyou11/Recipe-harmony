class FavoritesController < ApplicationController
  before_action :set_recipe

  def toggle_favorite
    if(@favorite = @recipe.favorites.find_by(user: current_user))
      @favorite.destroy
    else
      @recipe.favorites.create(user: current_user)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "recipe#{@recipe.id}favorites",
          partial: "recipes/recipe_favorites",
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