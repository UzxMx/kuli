class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.belongs_to :user, null: false
      t.string :name, null: false, default: ""
      t.string :owner_name, null: false, default: ""
      t.string :owner_telephone, null: false, default: ""
      
      t.timestamps
    end

    add_attachment :stores, :license_picture
  end
end
