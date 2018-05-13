class CreateCompanyCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :company_categories do |t|
      t.references :company, foreign_key: true
      t.references :category, foreign_key: true
    end
  end
end
