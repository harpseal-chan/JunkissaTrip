class AddKanaToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :kana, :string
  end
end
