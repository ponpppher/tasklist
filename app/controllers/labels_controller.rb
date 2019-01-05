# frozen_string_literal: true

class LabelsController < ApplicationController
  def create
    label = current_user.labels.build(label_params)

    if label.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end
end
