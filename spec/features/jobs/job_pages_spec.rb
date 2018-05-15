require 'rails_helper'

RSpec.describe 'Job Pages' do
  context 'User visits /jobs/new' do
    it 'they can create a new job' do
      company = Company.create!(name: 'ESPN')
      category = Category.create!(title: 'Web Development')
      visit new_company_job_path(company)

      fill_in 'job[title]', with: 'Developer'
      fill_in 'job[description]', with: 'So fun!'
      fill_in 'job[level_of_interest]', with: 80
      fill_in 'job[city]', with: 'Denver'
      # select 'Web Development', froml: 'Category'

      click_button 'Create Job'

      expect(current_path).to eq("/companies/#{company.id}/jobs/#{Job.last.id}")
      expect(page).to have_content('ESPN')
      expect(page).to have_content('Developer')
      expect(page).to have_content('80')
      expect(page).to have_content('Denver')
    end
  end
end
