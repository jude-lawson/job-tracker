class Contact < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email, :position
  belongs_to :company
end
