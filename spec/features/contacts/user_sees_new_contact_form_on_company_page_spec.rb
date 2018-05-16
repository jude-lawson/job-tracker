require 'rails_helper'

describe 'User sees a specific company page' do
  it "should display the specified company's information" do
    company = Company.create!(name: 'Ableton')

    visit company_path(company)

    expect(page).to have_content(company.name)
  end
  it "should show a form to add a new contact" do
    company = Company.create!(name: 'Microsoft')

    visit company_path(company)


    expect(page).to have_content('Add a Contact:')
    find_field('First name')
    find_field('Last name')
    find_field('Position')
    find_field('Email')
    find_field('Company')
  end
end
