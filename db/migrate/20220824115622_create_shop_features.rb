class CreateShopFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :shop_features do |t|
      t.references :shop, null: false, foreign_key: true
      t.references :feature, null: false, foreign_key: true

      t.timestamps
    end
  end
end
