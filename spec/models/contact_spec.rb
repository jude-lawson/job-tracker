require 'rails_helper'

describe Contact do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid if missing a first name' do
        city = City.new(title: 'Denver')
        company = Company.new(name: 'Coffee zone', city_id: city.id)
        contact = Contact.new(last_name: "Doe", position: "Manager", company_id: company.id)
      expect(contact).to be_invalid
    end
  end

      it 'is invalid if missing a last name' do
        city = City.new(title: 'Denver')
        company = Company.new(name: 'Coffee zone', city_id: city.id)
        contact = Contact.new(first_name: "John", position: "Manager", company_id: company.id)
      expect(contact).to be_invalid
    end

      it 'is invalid if missing a position' do
        city = City.new(title: 'Denver')
        company = Company.new(name: 'Coffee zone', city_id: city.id)
        contact = Contact.new(first_name: "John", last_name: "Doe", company_id: company.id)

      expect(contact).to be_invalid
    end

      it 'is invalid if missing a company_id' do
        contact = Contact.new(first_name: "John", last_name: "Doe", position: "Manager")
      end

    context 'valid attributes' do
      it 'is valid with a first name, last name, position, and company id' do
        city = City.create!(title: 'Scranton')
        company = Company.create!(name: 'Dunder Mifflin', city_id: city.id)
        contact = Contact.create!(first_name: "Dwight", last_name: "Schrute", position: "Assistant to the Regional Manager", company_id: company.id)

        expect(contact).to be_valid
      end
    end
  end
end
