require 'rails_helper'

describe Job do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a title" do
        job = Job.new(level_of_interest: 80, description: "Wahoo")
        expect(job).to be_invalid
      end

      it "is invalid without a level of interest" do
        job = Job.new(title: "Developer", description: "Wahoo")
        expect(job).to be_invalid
      end

      it "is invalid without a description" do
        job = Job.new(title: "Developer", level_of_interest: 80)
        expect(job).to be_invalid
      end
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo")
      expect(job).to respond_to(:company)
    end
    it 'belongs to a category' do
      job = Job.new(title: "UX", level_of_interest: 50, description: "Thing")
      expect(job).to respond_to(:category)
    end
  end
end
