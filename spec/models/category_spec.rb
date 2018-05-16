require 'rails_helper'

describe Category do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without a title' do
        category = Category.new()
        expect(category).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is valid with a unique title' do
        category = Category.new(title: "Engineering")
        expect(category).to be_valid
      end
    end
  end
  describe 'relationships' do
    it {should have_many(:jobs)}
  end
end
