require 'rails_helper'

describe City do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without a title' do
        city = City.create()
        expect(city).to be_invalid
      end
    end
    context 'valid attributes' do
      it 'is valid with a title' do
        city = City.create(name: 'Weslaco')
        expect(city).to be_valid
      end
    end
  end

  describe 'relationships' do
    it { should have_many(:jobs) }
  end
end
