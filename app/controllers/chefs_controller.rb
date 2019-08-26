# Responding on request for chefs
class ChefsController < ApplicationController
  attr_writer :chef
  before_action :require_same_chef, only: [:edit, :update]
  before_action :before_destroy, only: [:destroy]

  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)
  end

  def new
    self.chef = Chef.new
  end

  def create
    self.chef = Chef.new(chef_params)
    if chef.save
      cache_chef_id(chef.id)
      flash[:success] = "Welcome #{chef.name} !"
      redirect_to chef_path(chef)
    else
      render 'new'
    end
  end

  def show
    @chef_recipes = chef.recipes.paginate(page: params[:page], per_page: 5)
  end

  def edit; end

  def update
    if chef.update(chef_params)
      flash[:success] = 'Profile successfully updated !'
      redirect_to chef_path(chef)
    else
      render 'edit'
    end
  end

  def destroy
    if chef.destroy
      flash[:success] = 'Chef and all associated recipes has been deleted !'
      redirect_to chefs_path
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  private

  def chef
    @chef ||= ValidChefDecorator.find(params[:id])
  end

  def before_destroy
    # Only admins can delete users, but admins cant delete themselves.
    return if current_chef.admin? && current_chef.id != chef.id

    flash[:danger] = 'You are not allowed to perform this action !'
    redirect_to root_path
  end

  def require_same_chef
    return if current_chef.id == chef.id

    flash[:danger] = 'You cant perform this action on other chefs'
    redirect_to root_path
  end

  def chef_params
    params.require(:chef).permit(:name, :email, :password, :password_confirmation)
  end
end
