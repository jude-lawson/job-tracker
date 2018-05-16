require 'rails_helper'

RSpec.describe 'Category Pages' do
  before :each do
    @company1 = Company.create!(name: 'ESPN')
    @company2 = Company.create!(name: 'Apple')
    @company3 = Company.create(name: 'Google')

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
    @job3 = @company3.jobs.create!(title: 'Coolest Developer',
                                   description: 'This is a really cool job',
                                   level_of_interest: '5',
                                   city: 'Boulder', category_id: @category1.id)
     @job4 = @company3.jobs.create!(title: 'Cooler Developer',
                                    description: 'This is also a coolish job',
                                    level_of_interest: '4',
                                    city: 'Boulder', category_id: @category3.id)
  end

  context '/categories' do
    describe 'A user visits the categories page' do
      it 'they should see a list of all categories' do
        visit categories_path

        expect(page).to have_content(@category1.title)
        expect(page).to have_content(@category2.title)
        expect(page).to have_content(@category3.title)
        expect(page).to have_link("#{@category1.jobs.count} jobs")
        within("#category-" + @category2.id.to_s) do
          expect(page).to have_content("#{@category2.jobs.count} jobs")
        end
        within("#category-" + @category3.id.to_s) do
          expect(page).to have_content("#{@category3.jobs.count} jobs")
        end
      end
    end
  end

  context 'categories/new' do
    describe 'A user visits the new categories page' do
      it 'they should be able to create a new category' do
        visit new_category_path

        new_title = 'A New Category'

        fill_in 'category[title]', with: new_title
        click_button 'Create Category'

        expect(page).to have_current_path(jobs_path(category: new_title))
        expect(page).to have_content(new_title)

        expect(page).to_not have_content(@job1.title)
        expect(page).to_not have_content(@job2.title)
      end

      it 'if they enter a duplicate name, they should receive an error message' do
        visit new_category_path

        fill_in 'category[title]', with: @category1.title
        click_button 'Create Category'

        expect(page).to have_current_path(new_category_path)
        within('.notice') do
          expect(page).to have_content("Sorry, the category name #{@category1.title} already exists!")
        end
      end
    end
  end

  context '/jobs?category=:category_title' do
    describe 'A user visits a category\'s page' do
      it 'they should see all of the jobs for that specific category' do
        visit jobs_path(category: @category1.title)

        expect(page).to have_content("#{@category1.title} jobs")
        expect(page).to have_content("#{@job1.title} at #{@company1.name}")
        expect(page).to have_content("#{@job2.title} at #{@company2.name}")
        expect(page).to have_content("#{@job3.title} at #{@company3.name}")

        expect(page).to_not have_content("#{@job4.title} at #{@company3.name}")
      end
    end
  end
end
