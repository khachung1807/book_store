class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.integer :user_id, index: true
      t.datetime :started_day
      t.string :literacy, :work_type, :position
      t.decimal :salary
      t.boolean :manager, default: false

      t.timestamps
    end
  end
end
