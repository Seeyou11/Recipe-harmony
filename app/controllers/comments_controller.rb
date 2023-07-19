class CommentsController < ApplicationController
  before_action :set_recipe, only: [:create]
  

  def create 
    @comment = @recipe.comments.create(user: current_user, body: params[:comment_body])

    respond_to do |format|
      format.turbo_stream do 
        render turbo_stream: turbo_stream.replace(
          "recipe#{@recipe.id}comments",
          partial: "recipes/recipe_comments",
          locals: {recipe: @recipe}
        )
      end
    end
  end

  def destroy 
    @comment = Comment.find(params[:id])
    if(@comment.user == current_user)
      @comment.destroy

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.remove(
            "recipe#{@comment.recipe_id}ModalComment#{@comment.id}"
          )
        end
      end
    end
  end

  private
  def set_recipe 
    @recipe = Recipe.find(params[:recipe_id])
  end
end