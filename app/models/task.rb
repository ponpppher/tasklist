class Task < ApplicationRecord
  validates:title, presence:true
  validates:content, presence:true
  default_scope -> { order(created_at: :desc)}
end
