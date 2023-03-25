class Comment < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :article
  belongs_to :user

  validates_presence_of :body
end
