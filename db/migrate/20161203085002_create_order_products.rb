class CreateOrderProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :order_products do |t|
      t.belongs_to :order, null: false
      t.belongs_to :product, null: false

      t.integer :count, default: 0

      t.timestamps
    end
  end
end
