require 'rails_helper'

describe 'User sees a specific job page' do
  xit 'should display the specific job information' do
    job = Job.create(title: 'developer', level_of_interest: 78, description: 'build things')

    visit company_jobs_path(job)
    expect(page).to have_content(job.title)
    expect(page).to have_content(job.level_of_interest)
    expect(page).to have_content(job.description)
  end
  xit 'should display a form to add a new comment' do
    job = Job.create(title: 'UI person', level_of_interest: 20, description: 'make the user not hate us')

    visit company_jobs_path(job)

    expect(page).to have_content('Add a Comment:')
    find_field('Title').value
    find_field('Body').value
  end
end
