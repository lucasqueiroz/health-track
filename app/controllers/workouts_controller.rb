class WorkoutsController < ApplicationController
  before_action :redirect_logged_out_user, unless: :logged_in?
  before_action :set_workouts, only: :index
  before_action :set_workout, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @workout = Workout.new
  end

  def edit
  end

  def create
    @workout = Workout.new(workout_params)
    @workout.user = current_user
    if @workout.save
      flash[:success] = "Workout saved!"
      redirect_to workouts_path
    else
      render :new
    end
  end

  def update
    if @workout.update(workout_params)
      flash[:success] = "Workout updated!"
      redirect_to workouts_path
    else
      render :edit
    end
  end

  def destroy
    @workout.destroy
    flash[:success] = "Workout was removed!"
    redirect_to workouts_path
  end

  private

  def set_workouts
    @workouts = current_user.workouts.order(:occurred_at)
  end

  def set_workout
    @workout = Workout.find(params[:id])
  end

  def workout_params
    params.require(:workout).permit(:name, :calories, :occurred_at)
  end
end
