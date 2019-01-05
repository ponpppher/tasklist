# frozen_string_literal: true

module TasksHelper
  def choose_new_or_edit
    if action_name == 'edit'
      task_path
    else
      tasks_path
    end
  end
end
