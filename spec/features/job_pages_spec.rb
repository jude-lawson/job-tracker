require 'rails_helper'

RSpec.describe 'Job Pages' do

  before :each do
    @company1 = Company.create!(name: 'ESPN')
    @company2 = Company.create!(name: 'Apple')

    @category1 = Category.create(title: 'Web Development')
    @category2 = Category.create(title: 'iOS Development')
    
    @job1 = @company1.jobs.create!(title: 'Developer', 
                                   description: 'This is a cool job',
                                   level_of_interest: '4',
                                   city: 'Denver', category_id: @category1.id)
    @job2 = @company2.jobs.create!(title: 'Developer Too', 
                                   description: 'This is a not cool job',
                                   level_of_interest: '2',
                                   city: 'Denver', category_id: @category1.id)
  end

  context '/jobs/new' do
    describe 'A user visits the new job page' do
      it 'they can create a new job' do
        visit new_job_path

        new_title = 'Developer Three'
        new_loi = '3'
        new_city = 'Cupertino'
        new_desc = 'A sorta okay job'

        select @category2.title, from: 'job[category_id]'
        fill_in 'job[title]', with: new_title
        select @company2.name, from: 'job[company_id]'
        fill_in 'job[city]', with: new_city
        fill_in 'job[description]', with: new_desc
        select "#{new_loi} of 5", from: 'job[level_of_interest]'
        click_button 'Create Job'

        expect(current_path).to eq(job_path(Job.last))
        expect(page).to have_content(new_title)
        expect(page).to have_content(new_loi)
        expect(page).to have_content(new_city)
      end

      it 'they should be able to click the new category link and reach the new category page' do
        visit new_job_path

        click_link 'Add a new category'

        expect(current_path).to eq(new_category_path)
      end
    end
  end

  context '/jobs' do
    describe 'A user visits the jobs page' do
      it 'they should see all jobs for a company' do
        visit jobs_path

        expect(page).to have_content(@job1.title)
        expect(page).to have_content(@company1.name)
        expect(page).to have_content(@job2.title)
        expect(page).to have_content(@company2.name)
      end

      it 'they should be able to click a job link and reach a job\'s page' do
        visit jobs_path

        click_link(@job1.title)

        expect(current_path).to eq(job_path(@job1))
      end

      it 'they should be able to click the job\'s edit button to reach the edit form' do
        visit jobs_path

        within('#job-' + "#{@job2.id}") do
          click_link 'Edit'
        end

        expect(current_path).to eq(edit_job_path(@job2))
      end

      it 'they should be able to click a job\'s delete button to delete a job' do
        visit jobs_path
  
        within('#job-1') do
          click_link('Delete')
        end
  
        expect(current_path).to eq(jobs_path)
        expect(page).to have_content(@company2.name)
        expect(page).to have_content(@job2.title)
  
        expect(page).to_not have_content("#{@job1.title} at #{@company1.name}")
      end
    end
  end

  context '/jobs/:id' do
    describe 'A user visits a specific job\'s page' do
      it 'the user should see a specific job' do
        visit job_path(@job1)

        expect(page).to have_content("#{@job1.title} at #{@company1.name}")
        expect(page).to have_content(@job1.description)
        expect(page).to have_content("Interest: #{@job1.level_of_interest}")
        expect(page).to have_content("Location: #{@job1.city}")
        expect(page).to have_content("see other #{@job1.category.title} jobs")

        expect(page).to_not have_content(@job2.title)
        expect(page).to_not have_content(@job2.description)
      end
    end
  end

  context '/jobs/:id/edit' do
    describe 'A user visits the edit page for a job' do
      it 'they should be able to update a job' do
        visit edit_job_path(@job1)

        new_title = 'A New Title'
        new_description = 'A New Description'
        new_loi = '2 of 5'


        select @category2.title, from: 'job[category_id]'
        fill_in 'job[title]', with: new_title
        select @company2.name, from: 'job[company_id]'
        fill_in 'job[description]', with: new_description
        select new_loi, from: 'job[level_of_interest]'
        click_button 'Update Job'

        expect(current_path).to eq(job_path(@job1))
        expect(page).to have_content(new_title)
        expect(page).to have_content(new_description)
        expect(page).to have_content("Interest: #{new_loi[0]}")
        expect(page).to have_content(@category2.title)
        expect(page).to have_content(@company2.name)
      end
    end
  end
end
