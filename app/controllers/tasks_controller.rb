class TasksController < ApplicationController
  def index
    @task = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)
    task.save!
    redirect_to root_path
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    redirect_to root_path
  end

  def show
    @task = Task.find(params[:id])
    render :show
  end

  def destroy
    @task = Task.find(params[:id]).destroy
    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :content)
  end

end
