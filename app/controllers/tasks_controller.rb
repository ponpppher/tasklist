class TasksController < ApplicationController
  def index
    @task = Task.new
    if params[:sort_expired]
      @task = Task.all.order(limit_datetime: :desc)
    elsif params.include?(:task) && params[:task].include?(:search)
      case params[:task][:status_search]
      when "yet" then
        puts "yet"
        @task = Task.all.order(limit_datetime: :desc)
      when "start" then
        puts "start"
        @task = Task.all.order(limit_datetime: :desc)
      when "complete" then
        puts "comp"
        @task = Task.all.order(limit_datetime: :desc)
      else
        puts "else"
        @task = Task.all.order(created_at: :desc)
      end
      if params[:task][:title_search]
        puts "titlesearch"
        @task = @task.where("title Like ?", "%#{params[:task][:title_search]}%")
      end
    else
      @task = Task.all.order(created_at: :desc)
    end

  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, flash:{notice: t('view.create_task')}
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    redirect_to root_path, flash:{notice: t('view.update_task')}
  end

  def show
    @task = Task.find(params[:id])
    render :show
  end

  def destroy
    @task = Task.find(params[:id]).destroy
    redirect_to root_path, flash:{notice: t('view.delete_task')}
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :limit_datetime)
  end

end
