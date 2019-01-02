class TasksController < ApplicationController
  before_action :set_task, only:[:edit, :update, :show, :destroy]

  def index
    # confirm logged in 
    # 全件取得
    @q = current_user.tasks.ransack(params[:q])
    # 重複を削除した結果を返却
    @tasks = @q.result(distinct: true)
      #@tasks = current_user.tasks.sort_created_at

    # branch by sort parameter
    # expired priority and search flag
#    if params[:sort_expired]
#      @tasks = current_user.tasks.sort_expired
#    elsif params[:sort_priority]
#      tasks_priority = current_user.tasks.sort_priority
#      @tasks = tasks_priority.sort_created_at
#    elsif params.include?(:task) && params[:task].include?(:search)
#
#      # title search
#      unless params[:task][:title_search].blank?
#        title = params[:task][:title_search]
#        title_tasks = current_user.tasks.search_by_title(title)
#      else
#        title_tasks = current_user.tasks.sort_created_at
#      end
#        
#      # switch by status params
#      case params[:task][:status_search].to_sym
#      when :waiting then
#        @tasks = title_tasks.waiting
#      when :working then
#        @tasks = title_tasks.working
#      when :complated then
#        @tasks = title_tasks.complated
#      end
#
#      # search label or title
#      unless params[:task][:label_search].blank?
#        label_name = params[:task][:label_search]
#        labeled_tasks = Label.search_by_name(label_name)[0].labeling_task
#        @tasks = labeled_tasks.search_by_user_id(current_user.id)
#      end
#
#    end
    @task = @tasks.page(params[:page]).per(3)
  end

  def search
    # title contentで検索
    @q = current_user.tasks.ransack(search_params)
    # 重複削除
    @task = @q.result(distinct: true).page(params[:page]).per(3)
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

  def search_params
    params.require(:q).permit(:title_cont, :content)
  end

end
