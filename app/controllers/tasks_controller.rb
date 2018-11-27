class TasksController < ApplicationController
  before_action :set_task, only:[:edit, :update, :show, :destroy]
  NOT_YET = I18n.t('view.not_yet_started').freeze
  START = I18n.t('view.start').freeze
  COMPLETE= I18n.t('view.complete').freeze

  def index
    @task = Task.new
    if params[:sort_expired]
      @task = Task.all.order(limit_datetime: :desc)
    elsif params[:sort_priority]
      @task = Task.order(priority: :desc)
      @task = @task.order(created_at: :desc)
    elsif params.include?(:task) && params[:task].include?(:search)
      case params[:task][:status_search]
      when NOT_YET then
        @task = Task.not_yet_started
      when START then
        @task = Task.start
      when COMPLETE then
        @task = Task.complete
      else
        @task = Task.all.order(created_at: :desc)
      end
      unless params[:task][:title_search].blank?
        title = params[:task][:title_search]
        @task = @task.where("title LIKE?", "%#{title}%")
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
  end

  def update
    @task.update(task_params)
    redirect_to root_path, flash:{notice: t('view.update_task')}
  end

  def show
    render :show
  end

  def destroy
    @task.destroy
    redirect_to root_path, flash:{notice: t('view.delete_task')}
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :status, :priority, :limit_datetime)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
