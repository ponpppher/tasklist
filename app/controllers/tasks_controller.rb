# frozen_string_literal: true
require 'dotenv'

class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update show destroy]
  before_action :set_label, only: %i[index search new edit]

  def index
    # all data in each models
    @q = current_user.tasks.ransack(params[:q])
    @label = Label.new

    # to display calendar's tasks
    @calendar_task = current_user.tasks

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
    elsif params[:show_expired]
      # 5日以内に期限が来ているタスクを表示
      @tasks = Task.show_expired(current_user, ENV["EXPIRED_DAY"])
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
    render 'tasks/index'
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.includes(:user).build(task_params)

    if @task.save
      redirect_to tasks_path, flash: { notice: t('views.message.create_task') }
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, flash: { notice: t('views.message.update_task') }
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
    redirect_to tasks_path, flash: { notice: t('views.message.delete_task') }
  end

  private

  def task_params
    params.require(:task).permit(
      :title,
      :content,
      :status,
      :priority,
      :limit_datetime,
      :name,
      labeling_label_ids: []
    )
  end

  def set_task
    if params[:name] == "group"
      @task = Task.find_by(id: params[:id])
    else
      @task = current_user.tasks.find_by(id: params[:id])
    end
  end

  def set_label
    @labels = Label.where(user_id: current_user)
  end

  def search_params
    params.require(:q).permit(:title_cont, :status_eq, :labeling_label_id_eq)
  end
end
