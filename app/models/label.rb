class Label < ApplicationRecord
  validates :name, presence: true

  has_many :labeling, dependent: :destroy
  has_many :labeling_task, through: :labeling, source: :task
end
