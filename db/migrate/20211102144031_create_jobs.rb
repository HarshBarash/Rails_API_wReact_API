class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :company
      t.string :position
      t.string :description
    end
  end
end