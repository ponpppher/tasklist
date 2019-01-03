class TasksController < ApplicationController
  before_action :set_task, only:[:edit, :update, :show, :destroy]
  before_action :set_label, only:[:index, :search, :new, :edit]

  def index
    # all data in each models
    @q = current_user.tasks.ransack(params[:q])
    @label = Label.new

    # branch by sort parameter
    # expired priority and search flag
    if params[:sort_expired]
      @tasks = current_user.tasks.sort_expired
    elsif params[:sort_priority]
      tasks_priority = current_user.tasks.sort_priority
      @tasks = tasks_priority.sort_created_at

      # 全件取得
      # 重複を削除した結果を返却
      @tasks = @q.result(distinct: true)
    else
      # tasks in index page
      @tasks = current_user.tasks.sort_created_at
    end

    # pagenation
    @task = @tasks.page(params[:page]).per(3)
#    @task = @tasks.page(params[:page]).per(3)
  end

  def search
    @q = current_user.tasks.ransack(search_params)
    @task = @q.result.page(params[:page]).per(3)
    render "tasks/index"
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

      redirect_to tasks_path, flash:{notice: t('view.message.create_task')}
    else
      render :new
    end
  end

  def edit;end

  def update
#    @task = current_user.tasks.build(task_params)
    if @task.update(task_params)
      redirect_to tasks_path, flash:{notice: t('view.message.update_task')}
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
    redirect_to tasks_path, flash:{notice: t('view.message.delete_task')}
  end

  private

  def task_params
    params.require(:task).permit(
      :title,
      :content,
      :status,
      :priority,
      :limit_datetime,
     { :labeling_label_ids=> [] },
    )
  end

  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
  end

  def set_label
    @labels = Label.where(user_id:current_user)
  end

  def search_params
    params.require(:q).permit(:title_cont, :status_eq, :labeling_label_id_eq)
  end

end
