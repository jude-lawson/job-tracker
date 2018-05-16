require 'rails_helper'

describe 'User adds a new contact' do
  xit 'should redirect to specific company page' do
    company = Company.create!(name: 'Etsy')
    visit company_path(company)

    fill_in "contact[first_name]", with: 'Rose'
    fill_in "contact[last_name]", with: 'Smith'
    fill_in "contact[position]", with: 'Hiring manager'
    fill_in "contact[email]", with: 'rs@etsy.com'
    fill_in "contact[company_name]", with: company.name
    click_button "Create"

    expect(current_path).to eq("/companies/#{company.id}")
    expect(page).to have_content('Etsy')
    expect(page).to have_content('Rose Smith')
    expect(page).to have_content('Hiring manager')
    expect(page).to have_content('rs@etsy.com')
  end
end
