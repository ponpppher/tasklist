class Group < ApplicationRecord
  has_many :assigns, dependent: :destroy
  has_many :users, through: :assigns, source: :user
end
