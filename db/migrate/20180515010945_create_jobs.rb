class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.integer :level_of_interest
      t.text :description

      t.timestamps null: false
    end
  end
end
