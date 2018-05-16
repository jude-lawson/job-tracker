require 'rails_helper'

RSpec.describe 'Job Pages' do

  before :each do
    @company1 = Company.create!(name: "ESPN")
    @category = Category.create(title: 'Web Development')
    @job1 = @company1.jobs.create!(title: "Developer", description: 'This is a cool job', level_of_interest: 70, city: "Denver", category_id: @category.id)
    @job2 = @company1.jobs.create!(title: "Developer Too", description: 'This is a not cool job', level_of_interest: 70, city: "Denver", category_id: @category.id)
  end

  context 'User visits /jobs/new' do
    it 'they can create a new job' do
      visit new_company_job_path(@company1)

      fill_in 'job[title]', with: 'Developer'
      fill_in 'job[description]', with: 'So fun!'
      fill_in 'job[level_of_interest]', with: 80
      fill_in 'job[city]', with: 'Denver'
      select 'Web Development', from: 'job[category_id]'


      click_button 'Create Job'

      expect(current_path).to eq("/companies/#{@company1.id}/jobs/#{Job.last.id}")
      expect(page).to have_content('ESPN')
      expect(page).to have_content('Developer')
      expect(page).to have_content('80')
      expect(page).to have_content('Denver')
    end
  end

  context 'User visits /company/:company_id/jobs' do
    it 'they should see all jobs for a company' do
      visit company_jobs_path(@company1)

      expect(page).to have_content(@company1.name)
      expect(page).to have_content(@job1.title)
      expect(page).to have_content(@job2.title)
    end
  end

  context 'User visits company/:id/jobs/:id' do
    it 'the user should see a specific jobs for a specific company' do
      
      visit company_job_path(@company1, @job1)
  
      expect(page).to have_content(@company1.name)
      expect(page).to have_content(@job1.title)
      expect(page).to have_content(@job1.description)
      expect(page).to have_content(@job1.level_of_interest)

      expect(page).to_not have_content(@job2.title)
      expect(page).to_not have_content(@job2.description)
    end
  end

  context 'User visits /company/:id/jobs/:id/edit' do
    it 'they should be able to update a job' do
      visit edit_company_job_path(@company1, @job1)
      
      new_title = 'A New Title'
      new_description = 'A New Description'
      new_loi = '19'

      fill_in 'job[title]', with: new_title
      fill_in 'job[description]', with: new_description
      fill_in 'job[level_of_interest]', with: new_loi
      click_button 'Update Job'

      expect(current_path).to eq(company_job_path(@company1, @job1))
      expect(page).to have_content(new_title)
      expect(page).to have_content(new_description)
      expect(page).to have_content(new_loi)
    end
  end

  context 'User visits' do
    it 'they should be able to delete a job' do
      visit company_jobs_path(@company1)

      within('#job-1') do
        click_link('Delete')
      end

      save_and_open_page
      expect(current_path).to eq(company_jobs_path(@company1))
      expect(page).to have_content(@company1.name)
      expect(page).to have_content(@job2.title)

      expect(page).to_not have_content(@job1.title)
    end
  end

end
