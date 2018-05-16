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

describe 'User visits a specific job page' do
  it 'should display the specific job information' do
    visit job_path(@job1)
    expect(page).to have_content(@job1.title)

    expect(page).to have_content(@job1.level_of_interest)
    expect(page).to have_content(@job1.description)
  end

  it 'should display a form to add a new comment' do
    visit job_path(@job1)

    expect(page).to have_content('Add a Comment:')
    find_field('Title').value
    find_field('Body').value
    end
  end
end
