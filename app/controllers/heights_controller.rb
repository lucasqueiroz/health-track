class HeightsController < ApplicationController
  before_action :check_user
  before_action :set_heights, only: :index

  def index
  end

  def show
    @height = Height.find(params[:id])
  end

  def new
    @height = Height.new
  end

  def create
    height = Height.new(height_params)
    height.user = current_user
    if height.save
      flash[:success] = "Height saved!"
      redirect_to heights_path
    else
      flash[:danger] = "Could not save the height! Please try again."
      render :new
    end
  end

  private

  def set_heights
    @heights = current_user.heights.order(:measured_at)
  end

  def height_params
    params.require(:height).permit(:measurement, :measured_at)
  end
end
