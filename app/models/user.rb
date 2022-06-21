class User < ApplicationRecord
  validates :username, presence: true

  scope :all_except, ->(user) { where.not(id: user) }

  after_create_commit { broadcast_append_to :users }
end
