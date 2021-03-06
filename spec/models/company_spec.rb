require 'rails_helper'

describe Company do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        company = Company.new()
        expect(company).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name" do
        city = City.create(name: "Mission")
        company = Company.new(name: "Dropbox")
        expect(company).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many jobs" do
      city = City.new(name: 'Los Angeles')
      company = Company.new(name: "Dropbox")
      expect(company).to respond_to(:jobs)
    end
  end
end
