class CreateOrderSources < ActiveRecord::Migration[6.0]
  def change
    create_table :order_sources do |t|
      t.string      :postal_code,     null: false
      t.integer     :prefecture_id,   null: false
      t.string      :municipal,       null: false
      t.string      :address,         null: false
      t.string      :phone_number,    null: false
      t.string      :building_name
      t.references  :order,           foreign_key: true
      t.timestamps
    end
  end
end
