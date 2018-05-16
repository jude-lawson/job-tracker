require 'rails_helper'

RSpec.describe Comment do
  before :each do
    company = Company.create!(name: 'The Company')
    category = Category.create!(title: 'Cool Jobssss')
    city = City.create!(name: 'Denver')
    @job = Job.create!(title: 'Cool Job', level_of_interest: 2, description: 'The coolest job', company_id: company.id, category_id: category.id, city_id: city.id)
  end

  describe 'validations' do
    xit 'should be invalid without a title' do
      comment = @job.comments.new(body: "Worst comment ever")

      expect(comment).to be_invalid
    end

    xit 'should be invalid without a body' do
      comment = @job.comments.new(title: "Best comment ever")

      expect(comment).to be_invalid
    end

    xit 'should be valid with a title and a body' do
      comment = @job.comments.new(title: "Good", body: "I hope they hire me")

      expect(comment).to be_valid
    end
  end
end
