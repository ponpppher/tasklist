# frozen_string_literal: true

class LabelsController < ApplicationController
  def index
    @labels = current_user.labels

    # to display label ranking
    @chart_data = User.ag(current_user)
  end

  def create
    label = current_user.labels.build(label_params)

    if label.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    label = Label.find(params[:id])
    label.destroy
    redirect_to labels_path, notice: "label deleted"
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end
end
