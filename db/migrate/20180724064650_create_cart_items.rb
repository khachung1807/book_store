class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer :book_id, index: true
      t.integer :cart_id, index: true
      t.integer :quantity
      t.decimal :discount, :price

      t.timestamps
    end
  end
end
