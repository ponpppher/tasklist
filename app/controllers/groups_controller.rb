class GroupsController < ApplicationController
  before_action :set_params, only: %i[show edit update destroy]
  before_action :owner_authentication, only: %i[edit update destroy]

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
    if @group.users.find_by(id: current_user)
      @group
    else
      redirect_to groups_path , notice: "only group member can see detail page"
    end
  end

  def edit
  end

  def update
    @group.owner_id = current_user.id
    if @group.update(group_params)
      redirect_to groups_path, notice:"update sucess"
    else
      flash[:notice] = "can not update group infomation"
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, notice: "ユーザーの登録を削除しました"
  end

  private

  def group_params
    params.require(:group).permit(:name, :owner_id)
  end

  def set_params
    @group = Group.find(params[:id])
  end

  def owner_authentication
    if @group.owner_id != current_user.id
      redirect_to groups_path, notice: "only owner user can action #{action_name}"
    end
  end

end
