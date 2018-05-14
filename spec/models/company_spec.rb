require 'rails_helper'

describe Company do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        company = Company.new()
        expect(company).to be_invalid
      end

      it "has a unique name" do
        city = City.create(title: 'Pharr')
        company_1 = Company.create(name: "Dropbox", city_id: city.id)
        company_2 = Company.new(name: "Dropbox", city_id: city.id)
        expect(company_2).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a unique name and a city" do
        city = City.create(title: "Mission")
        company = Company.new(name: "Dropbox", city_id: city.id)
        expect(company).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many jobs" do
      city = City.new(title: 'Los Angeles')
      company = Company.new(name: "Dropbox", city_id: city.id)
      expect(company).to respond_to(:jobs)
    end
    it 'belongs to a city' do
      city = City.new(title: 'San Francisco')
      company = Company.new(name: "Spotify", city_id: city.id)
      expect(company).to respond_to(:city)
    end
  end
end
