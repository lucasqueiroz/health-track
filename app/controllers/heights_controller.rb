class HeightsController < ApplicationController
  before_action :check_user
  before_action :set_heights, only: :index
  before_action :set_height, only: [:edit, :update, :destroy]

  def index
  end

  def show
    @height = Height.find(params[:id])
  end

  def new
    @height = Height.new
  end

  def edit
  end

  def create
    @height = Height.new(height_params)
    @height.user = current_user
    if @height.save
      flash[:success] = "Height saved!"
      redirect_to heights_path
    else
      render :new
    end
  end

  def update
    if @height.update(height_params)
      flash[:success] = "Height updated!"
      redirect_to heights_path
    else
      render :edit
    end
  end

  def destroy
    @height.destroy
    flash[:success] = "Height was removed!"
    redirect_to heights_path
  end

  private

  def set_heights
    @heights = current_user.heights.order(:measured_at)
  end

  def set_height
    @height = Height.find(params[:id])
  end

  def height_params
    params.require(:height).permit(:measurement, :measured_at)
  end
end
