class CreateBookAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :book_authors do |t|
      t.referances :book
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
