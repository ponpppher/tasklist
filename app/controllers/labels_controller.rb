class LabelsController < ApplicationController
  def new
    @labels = Label.where(user_id: current_user)
  end

  def create
  end
end
