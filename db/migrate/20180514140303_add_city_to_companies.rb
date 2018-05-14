class AddCityToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_reference :companies, :city, foreign_key: true
  end
end
