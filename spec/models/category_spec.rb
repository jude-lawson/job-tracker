require 'rails_helper'

describe Category do
  describe 'Validations' do
    it { should validate_presence_of(:title) }
  end
  describe 'relationships' do
    it { should have_many(:jobs) }
  end
end
