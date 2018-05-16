require 'rails_helper'

describe 'User adds a new comment' do
  xit 'should redirect ot the specific job page' do
    job = Job.create(title: 'Salesperson', level_of_interest: 4, description: 'All about the bottom line')

    visit company_jobs_path(job)

    fill_in "comment[title]", with: 'ew'
    fill_in 'comment[body]', with: 'I cant even'
    click_button 'Submit'

    expect(current_path).to eq("/companies/jobs/#{job.id}")
    expect(page).to have_content('ew')
    expect(page).to have_content('I cant even')
  end
end
