class GroupsController < ApplicationController
  before_action :set_params, only: %i[show edit destroy]

  def index
    @groups = Group.all.includes([:assigns, :users])
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    
    if @group.save
      assign = current_user.assigns.create(group_id: @group.id)
      if assign.save
        redirect_to groups_path, notice: "create group success"
      else
        render :index
      end
    else
      render :index
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
  end

  def update
    @group = Group.new
    @group.owner_id = current_user.id
    if @group.update(group_params)
      redirect_to groups_path, notice:"update sucess"
    else
      render :edit
    end
  end

  def destroy
    if @group.owner_id != current_user.id
      @group.destroy
      redirect_to groups_path, notice: "ユーザーの登録を削除しました"
    else
      flash[:notice] = "can not delete owner user"
      render :index
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :owner_id)
  end

  def set_params
    @group = Group.find(params[:id])
  end

end
