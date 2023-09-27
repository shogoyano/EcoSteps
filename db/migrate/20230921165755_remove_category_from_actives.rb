class RemoveCategoryFromActives < ActiveRecord::Migration[6.1]
  def change
    remove_column :actives, :category, :string
  end
end
