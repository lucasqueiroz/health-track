class WeightsController < ApplicationController
  before_action :check_user
  before_action :set_weights, only: :index
  before_action :set_weight, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @height = Weight.new
  end

  def edit
  end

  def create
    @weight = Weight.new(weight_params)
    @weight.user = current_user
    if @weight.save
      flash[:success] = "Weight saved!"
      redirect_to weights_path
    else
      render :new
    end
  end

  def update
    if @weight.update(weight_params)
      flash[:success] = "Weight updated!"
      redirect_to weights_path
    else
      render :edit
    end
  end

  def destroy
    @weight.destroy
    flash[:success] = "Weight was removed!"
    redirect_to weights_path
  end

  private

  def set_weights
    @weights = current_user.weights.order(:measured_at)
  end

  def set_weight
    @weight = Weight.find(params[:id])
  end

  def weight_params
    params.require(:weight).permit(:measurement, :measured_at)
  end
end
