class User < ApplicationRecord
  validates :username, presence: true

  scope :all_except, ->(user) { where.not(id: user) }
end
