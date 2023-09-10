class AddUserIdToActives < ActiveRecord::Migration[6.1]
  def change
    add_column :actives, :user_id, :integer
  end
end
