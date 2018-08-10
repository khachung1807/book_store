class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.integer :category_id, index: true
      t.integer :published_year, :quantity, :access_count
      t.string :name, :author, :publisher, :description, :image
      t.decimal :price, :discount
      t.boolean :trend, default: false

      t.timestamps index: true
    end
  end
end
