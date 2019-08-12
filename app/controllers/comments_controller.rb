# Class for managing comment requests
class CommentsController < ApplicationController
  before_action :require_chef, oly: [:create]

  def create
    @comment = create_comment
    if @comment.save
      flash[:success] = 'Comment was successfully created !'
      redirect_to recipe_path(@recipe)
    else
      flash[:danger] = 'Comment was not created !'
      redirect_back(fallback_location: recipes_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end

  def create_comment
    @recipe = ValidRecipeDecorator.find(params[:recipe_id])
    comment = Comment.new(comment_params)
    comment.recipe_id = @recipe.id
    comment.chef_id = current_chef.id
    comment
  end
end
