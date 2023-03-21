class Article < ApplicationRecord
  default_scope { order(created_at: :desc) }

  validates_presence_of :title, :body
end
