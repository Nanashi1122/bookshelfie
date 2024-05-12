class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.integer :user_id
      t.string :title
      t.string :publisher
      t.integer :list_price
      t.integer :page_count
      t.string :description
      t.string :ISBN
      t.string :published_date
      t.string :image_link

      t.timestamps
    end
  end
end
