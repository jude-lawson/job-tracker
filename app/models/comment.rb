class Comment < ApplicationRecord
  validates_presence_of :title, :body
  belongs_to :job
end
