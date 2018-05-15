require 'rails_helper'

RSpec.describe Comment do
  describe 'validations' do
    it 'should be invalid without a title' do
      comment = Comment.new(body: "Worst comment ever")

      expect(comment).to be_invalid
    end
    it 'should be invalid without a body' do
      comment = Comment.new(title: "Best comment ever")

      expect(comment).to be_invalid
    end
    it 'should be valid with a title and a body' do
      comment = Comment.new(title: "Good", body: "I hope they hire me")

      expect(comment).to be_valid
    end
  end
end
