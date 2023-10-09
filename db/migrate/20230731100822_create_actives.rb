class CreateActives < ActiveRecord::Migration[6.1]
  def change
    create_table :actives do |t|
      t.string :title
      t.text :about
      t.string :image
      t.integer :star
      t.string :category
      t.timestamps
    end
  end
end
