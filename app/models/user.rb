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
end
