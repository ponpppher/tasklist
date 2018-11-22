class Task < ApplicationRecord
  default_scope -> { order(created_at: :desc)}
end
