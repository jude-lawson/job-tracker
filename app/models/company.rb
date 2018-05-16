class Company < ApplicationRecord
  validates_presence_of :name
  has_many :jobs
  has_many :contacts
end
