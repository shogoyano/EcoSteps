class AddImageToActives < ActiveRecord::Migration[6.1]
  def change
    add_column :actives, :image, :string
  end
end
