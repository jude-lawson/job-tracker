class City < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :companies
end
