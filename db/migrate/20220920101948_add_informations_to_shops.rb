class AddInformationsToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :smoking, :string
    add_column :shops, :payment, :string
    add_column :shops, :access, :string
  end
end
