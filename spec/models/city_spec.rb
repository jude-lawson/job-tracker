require 'rails_helper'

describe City do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without a title'
      city = City.create()
      expect(city).to be_invalid
    end
      it 'is invalid with a duplicate name' do
        city_1 = City.create(title: "McAllen")
        city_2 = City.new(title: "McAllen")
        expect(city_2).to be_invalid
      end
    context 'valid attributes' do
      it 'is valid with a unique title' do
        city = City.create(title: 'Weslaco')
        expect(city).to be_valid
      end
    end
    describe 'relationships' do
      it {should have_many(:companies)}
    end
  end
end
