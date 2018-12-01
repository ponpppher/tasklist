class TasksController < ApplicationController
  before_action :set_task, only:[:edit, :update, :show, :destroy]
  NOT_YET = I18n.t('view.not_yet_started').freeze
  START = I18n.t('view.start').freeze
  COMPLETE= I18n.t('view.complete').freeze

  def index
    if params[:sort_expired]
      @task = current_user.tasks.order(limit_datetime: :desc)
      #@task = Task.all.order(limit_datetime: :desc)
    elsif params[:sort_priority]
      @task = current_user.tasks.order(priority: :desc)
      @task = @task.order(created_at: :desc)
    elsif params.include?(:task) && params[:task].include?(:search)
      case params[:task][:status_search]
      when NOT_YET then
        @task = current_user.tasks.not_yet_started
      when START then
        @task = current_user.tasks.start
      when COMPLETE then
        @task = current_user.tasks.complete
      else
        @task = current_user.tasks.order(created_at: :desc)
      end
      unless params[:task][:title_search].blank?
        title = params[:task][:title_search]
        @task = @task.where("title LIKE?", "%#{title}%")
      end
    else
      if current_user
        @task = current_user.tasks.order(created_at: :desc)
      else
        @task = Task.order(created_at: :desc)
      end
    end
    @task = @task.page(params[:page]).per(3)

  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      puts "id:#{@task.id}"
      labels = params[:task][:label_ids]
      labels.each do |label|
        puts "label:#{label}"
      end
      redirect_to tasks_path, flash:{notice: t('view.create_task')}
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, flash:{notice: t('view.update_task')}
    else
      render :edit
    end
  end

  def show
    render :show
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, flash:{notice: t('view.delete_task')}
  end

  private

  def task_params
    params.require(:task).permit(
      :title,
      :content,
      :status,
      :priority,
      :limit_datetime,
    )
  end

  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
  end

end
