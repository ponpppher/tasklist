class User < ApplicationRecord
  before_validation { email.downcase! }
  has_secure_password

  validates :name, presence: true, length: { maximum:30 }
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: true
end
