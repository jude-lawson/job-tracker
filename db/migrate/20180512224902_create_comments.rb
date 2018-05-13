class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :job_id
      t.string :title
      t.text :body
      t.integer :user_id
    end
  end
end
