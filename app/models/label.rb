# frozen_string_literal: true

class Label < ApplicationRecord
  validates :name, presence: true

  # search by
  scope :search_by_name, ->(name) { where(name: name) }

  belongs_to :user
  has_many :labeling, dependent: :destroy
  has_many :labeling_task, through: :labeling, source: :task
end
