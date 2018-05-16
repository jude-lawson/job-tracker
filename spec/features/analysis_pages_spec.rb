require 'rails_helper'

RSpec.describe 'Analysis Pages' do
  before :each do
    @company1 = Company.create!(name: 'ESPN')
    @company2 = Company.create!(name: 'Apple')
    @company3 = Company.create!(name: 'Google')

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
                                   city: 'Phoenix', category_id: @category1.id)
    @job3 = @company3.jobs.create!(title: 'Coolest Developer',
                                   description: 'This is a really cool job',
                                   level_of_interest: '5',
                                   city: 'Boulder', category_id: @category1.id)
    @job4 = @company3.jobs.create!(title: 'Cooler Developer',
                                   description: 'This is also a coolish job',
                                   level_of_interest: '4',
                                   city: 'Boulder', ctageory_id: @category3.id)
  end

  context '/jobs?sort=location' do
    describe 'A user visits the jobs page sorting by location' do
      xit 'they should see a list of jobs sorted by city' do
        visit '/jobs?sort=location'

        within('#denver-jobs') do
          expect(page).to have_content("#{@job1.title} at #{@company1.name}")
        end

        within('#phoenix-jobs') do
          expect(page).to have_content("#{@job2.title} at #{@company2.name}")
        end

        within('#boulder-jobs') do
          expect(page).to have_content("#{@job3.title} at #{@company3.name}")
          expect(page).to have_content("#{@job4.title} at #{@company3.name}")
        end
      end
    end
  end

  context '/dashboard' do
    describe 'A user visits the dashboard page' do
      xit 'they should see a count of jobs for each level of interest' do
        visit '/dashboard'

        expect(page).to have_content("Interest Level 5: 1")
        expect(page).to have_content("Interest Level 4: 2")
        expect(page).to have_content("Interest Level 3: 1")
      end

      xit 'they should see the top 3 companies ranked by average level of interest' do
        visit '/dashboard'

        within('#top-companies') do
          within('#first-rank') do
            expect(page).to have_content("#{@company3.name}")
          end
          within('#second-rank') do
            expect(page).to have_content("#{@company1.name}")
          end
          within('#third-rank') do
            expect(page).to have_content("#{@company2.name}")
          end
        end
      end

      xit 'they should see a list of the number of jobs per location' do
        visit '/dashboard'

        within('#jobs-per-location') do
          expect(page).to have_link("#{@company3.name} jobs")
          expect(page).to have_link("#{@company2.name} jobs")
          expect(page).to have_link("#{@company1.name} jobs")
          expect(page).to have_content("#{@company3.jobs.count} jobs")
          expect(page).to have_content("#{@company2.jobs.count} jobs")
          expect(page).to have_content("#{@company1.jobs.count} jobs")
        end
      end

      xit 'they should be able to click a link for the number of jobs in a location and visit that location\'s jobs page' do
        visit '/dashboard'

        within('#jobs_per-location') do
          click_link("#{@company3.name} jobs")
        end

        expect(current_path).to eq(jobs_path)
        # Need an expectation checking the page params here
        expect(page).to have_content("#{@company3.name} jobs")
        expect(page).to have_content(@job3.title)
        expect(page).to have_content(@job3.description)
        expect(page).to have_content(@job3.city)
        expect(page).to have_content(@job3.level_of_interest)
        expect(page).to have_content(@job4.title)
        expect(page).to have_content(@job4.description)
        expect(page).to have_content(@job4.city)
        expect(page).to have_content(@job4.level_of_interest)

        expect(page).to_not have_content(@job1.title)
        expect(page).to_not have_content(@job1.description)
        expect(page).to_not have_content(@job1.city)
        expect(page).to_not have_content(@job1.level_of_interest)
        expect(page).to_not have_content(@job2.title)
        expect(page).to_not have_content(@job2.description)
        expect(page).to_not have_content(@job2.city)
        expect(page).to_not have_content(@job2.level_of_interest)
      end
    end
  end

  context '/jobs?sort=level_of_interest' do
    describe 'A user visits the jobs page sorting by level of interest' do
      xit 'they should see a list of jobs sort by level of interest' do
        visit '/jobs?sort=level_of_interest'

        within('#level4') do
          expect (page).to have_content(@job1.title)
          expect (page).to have_content(@job4.title)
        end

        within('#level2') do
          expect(page).to have_content(@job2.title)
        end

        within('#level5') do
          expect(page).to have_content(@job3.title)
        end
      end
    end
  end
end
