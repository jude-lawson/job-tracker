require 'rails_helper'

describe 'User sees a specific company page' do
  xit "should display the specified company's information" do
    company = Company.create!(name: 'Ableton')

    visit company_path(company)

    expect(page).to have_content(company.name)
  end
  xit "should show a form to add a new contact" do
    company = Company.create!(name: 'Microsoft')

    visit company_path(company)


    expect(page).to have_content('Add a Contact:')
    expect(page).to have_field(company.contacts[first_name])
    expect(page).to have_field(company.contacts[last_name])
    expect(page).to have_field(company.contacts[position])

    expect(page).to have_field(company.contacts[email])

    expect(page).to have_field(company.contacts[company])
  end
end
