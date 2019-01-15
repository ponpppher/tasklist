class AssignsController < ApplicationController
  def create
    assign = Assign.new(group_id: params[:group_id])
    assign.user_id = current_user.id
    if assign.save
      redirect_to groups_path
    else
      render groups_path
    end
  end

  def destroy
    assign = current_user.assigns.find_by(group_id: params[:group_id])
    if assign.present?
      assign.destroy
      redirect_to groups_path, notice: "離脱しました"
    else
      redirect_to groups_path, notice: "離脱できませんでした"
    end
  end

end

