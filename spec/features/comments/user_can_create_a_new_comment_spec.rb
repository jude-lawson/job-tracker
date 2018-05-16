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

describe 'User adds a new comment' do
  it 'should redirect ot the specific job page' do

    visit job_path(@job1)

    fill_in "comment[title]", with: 'ew'
    fill_in 'comment[body]', with: 'I cant even'
    click_button 'Create Comment'

    expect(current_path).to eq("/jobs/#{@job1.id}")
    expect(page).to have_content('ew')
    expect(page).to have_content('I cant even')
    end
  end
end
