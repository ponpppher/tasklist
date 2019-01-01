class Task < ApplicationRecord

  # validates parameters
  validates :title, presence:true, length: { in: 1..250 }
  validates :content, presence:true, length: { in: 1..500 }
  validates :limit_datetime, presence:true
  validates :priority, presence:true
  validates :status, presence:true

  enum status: { waiting: 0, working: 1, complated: 2 }
  enum priority: { low: 0, middle: 1, high: 2 }

  scope :search_by_user_id, -> (id){ where(user_id: id) }
  scope :search_by_title, -> (title){ where("title LIKE?", "%#{title}%") }

  # scope oerderby
  scope :sort_expired, -> {order(limit_datetime: :desc)}
  scope :sort_priority, -> {order(priority: :desc)}
  scope :sort_created_at, -> {order(created_at: :desc)}

  belongs_to :user

  has_many :labeling, dependent: :destroy
  has_many :labeling_label, through: :labeling, source: :label
end
