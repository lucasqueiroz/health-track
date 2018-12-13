class FoodsController < ApplicationController
  before_action :redirect_logged_out_user, unless: :logged_in?
  before_action :set_foods, only: :index
  before_action :set_food, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @food = Food.new
  end

  def edit
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user
    if @food.save
      flash[:success] = "Food saved!"
      redirect_to foods_path
    else
      render :new
    end
  end

  def update
    if @food.update(food_params)
      flash[:success] = "Food updated!"
      redirect_to foods_path
    else
      render :edit
    end
  end

  def destroy
    @food.destroy
    flash[:success] = "Food was removed!"
    redirect_to foods_path
  end

  private

  def set_foods
    @foods = current_user.foods.order(:occurred_at)
  end

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :calories, :occurred_at)
  end
end
