class CreateFilms < ActiveRecord::Migration[6.1]
  def change
    create_table :films do |t|
      t.string :title
      t.string :release_date
      t.string :rating
      t.integer :genre_id
      t.integer :producer_id
     
      t.timestamps
    end
  end
end
