class TasksController < ApplicationController
  before_action :set_task, only:[:edit, :update, :show, :destroy]

  def index
    # confirm logged in 
    if current_user
      @tasks = current_user.tasks.sort_created_at
    end

    # branch by sort parameter
    # expired priority and search flag
    if params[:sort_expired]
      @tasks = current_user.tasks.sort_expired
    elsif params[:sort_priority]
      tasks_priority = current_user.tasks.sort_priority
      @tasks = tasks_priority.sort_created_at
    elsif params.include?(:task) && params[:task].include?(:search)
      # switch by status params
      # NOT_YET START COMPLATE
      case params[:task][:status_search]
      when NOT_YET then
        @tasks = current_user.tasks.not_yet_started
      when START then
        @tasks = current_user.tasks.start
      when COMPLETE then
        @tasks = current_user.tasks.complete
      else
        @tasks = current_user.tasks.sort_created_at
      end
      # search label or title
      unless params[:task][:label_search].blank?
        label_name = params[:task][:label_search]
        labeled_tasks = Label.search_by_name(label_name)[0].labeling_task
        @tasks = labeled_tasks.search_by_user_id(current_user.id)
      end
      unless params[:task][:title_search].blank?
        title = params[:task][:title_search]
        @tasks = current_user.tasks.search_by_title(title)
      end
    end
    @task = @tasks.page(params[:page]).per(3)
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      # insert task id
      task_id = @task.id

      # チェックされたlabelを取得し、
      # label毎にtaskと紐づけセーブする
      unless params[:task][:label_ids].blank?
        labels = params[:task][:label_ids]
        labels.each do |label_id|
          label_ins = Labeling.new({task_id: task_id, label_id: label_id})
          label_ins.save
        end
      end

      puts "create label:#{Labeling.where(task_id: task_id)}"
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
    @labels = @task.labeling_label
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
