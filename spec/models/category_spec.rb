require 'rails_helper'

RSpec.describe do
  before :each do
    @category = Category.create!(title: 'Engineering')
    @company = Company.create!(name: 'Cool Company')
    @job1 = Job.create!(title: "Developer", level_of_interest: 40, city: "Denver", company: @company, category_id: @category.id)
  end

  describe Category do
    describe 'validations' do
      context 'invalid attributes' do
        it 'is invalid without a title' do
          category = Category.new()
          expect(category).to be_invalid
        end

        it 'has a unique title' do
          Category.create(title: 'Finances')
          category = Category.new(title: 'Finances')
          expect(category).to be_invalid
        end
      end

      context 'valid attributes' do
        it 'is valid with a unique title' do
          expect(@category).to be_valid
        end
      end
    end
    describe 'relationships' do
      it { should have_many(:jobs) }
    end
  end
end