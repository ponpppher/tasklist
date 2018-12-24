class Task < ApplicationRecord
  NOT_YET = "未着手".freeze
  START = "着手".freeze
  COMPLETE= "完了".freeze

  validates:title, presence:true, length: { in: 1..250 }
  validates:content, presence:true, length: { in: 1..500 }
  validates:limit_datetime, presence:true
  validates:priority, presence:true

  enum priority: { low: 0, middle: 1, high: 2 }

  scope :not_yet_started, -> {where(status: NOT_YET)}
  scope :start, -> {where(status: START)}
  scope :complete, -> {where(status: COMPLETE)}

  belongs_to :user

  has_many :labeling, dependent: :destroy
  has_many :labeling_label, through: :labeling, source: :label
end
