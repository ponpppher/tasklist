class GroupsController < ApplicationController
  before_action :set_params, only: %i[show edit destroy]

  def index
    @groups = Group.all
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
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
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path 
  end

  private

  def group_params
    params.require(:group).permit(:name, :owner_id)
  end

  def set_params
    @group = Group.find(params[:id])
  end

end
