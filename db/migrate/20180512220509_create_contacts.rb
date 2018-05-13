class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :position
      t.integer :company_id
      
      t.timestamps
    end
  end
end
