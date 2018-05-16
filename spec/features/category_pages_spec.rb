require 'rails_helper'

RSpec.describe do 'Category Pages' do
  before :each do
    @company1 = Company.create!(name: 'ESPN')
    @company2 = Company.create!(name: 'Apple')

    @category1 = Category.create!(title: 'Web Development')
    @category2 = Category.create!(title: 'iOS Development')
    @category3 = Category.create!(title: 'Android Development')
    
    @job1 = @company1.jobs.create!(title: 'Developer', 
                                   description: 'This is a cool job',
                                   level_of_interest: '4',
                                   city: 'Denver', category_id: @category1.id)
    @job2 = @company2.jobs.create!(title: 'Developer Too', 
                                   description: 'This is a not cool job',
                                   level_of_interest: '2',
                                   city: 'Denver', category_id: @category1.id)
  end

  context '/categories' do
    describe 'A user visits the categories page' do
      it 'they should see a list of all categories' do
        visit categories_path

        expect(page).to have_content(@category1.title)
        expect(page).to have_content(@category2.title)
        expect(page).to have_content(@category3.title)
      end
    end
  end
end