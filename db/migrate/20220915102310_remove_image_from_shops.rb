class RemoveImageFromShops < ActiveRecord::Migration[6.1]
  def change
    remove_column :shops, :image, :string
  end
end
