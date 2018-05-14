class AddCityToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_reference :companies, :jobs, foreign_key: true
  end
end
