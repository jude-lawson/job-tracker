class Job < ApplicationRecord
  validates_presence_of :title, :level_of_interest, :description, :city
  has_many :comments
  belongs_to :company
  belongs_to :category

end
