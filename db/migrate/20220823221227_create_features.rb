class CreateFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :features do |t|
      t.string :icon_name
      t.string :detail

      t.timestamps
    end
  end
end
