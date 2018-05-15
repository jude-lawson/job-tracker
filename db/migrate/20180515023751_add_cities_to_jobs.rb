class AddCitiesToJobs < ActiveRecord::Migration[5.1]
  def change
    add_reference :jobs, :city, foreign_key: true
  end
end
