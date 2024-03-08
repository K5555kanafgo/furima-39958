class CreateBuyers < ActiveRecord::Migration[7.0]
  def change
    create_table :buyers do |t|
      t.string      :post_code,        null: false
      t.integer     :prefecture_id,    null: false
      t.string      :number,           null: false
      t.string      :telephone_number, null: false
      t.string      :building_name
      t.references  :item_purchase,    null: false, foreign_key: true
      t.timestamps
    end
  end
end
