# frozen_string_literal: true

class User < ApplicationRecord
  before_validation { email.downcase! }
  has_secure_password

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true

  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy

  has_many :assigns, dependent: :destroy
  has_many :groups, through: :assigns, source: :group

  def self.ag(inp_user)
    user_labels = inp_user.labels
    label_syms = user_labels.pluck(:name).map{|key| [key.to_sym, 0]}.to_h
    
    user_tasks = inp_user.tasks.includes([:labeling, :labeling_label])

    user_tasks.each do | task |
      task.labeling_label.each do | label|
        label_syms[label.name.to_sym] += 1
      end
    end
    label_syms
  end
end
