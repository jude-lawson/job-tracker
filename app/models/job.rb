class Job < ApplicationRecord
  validates_presence_of :title, :level_of_interest, :description
end
