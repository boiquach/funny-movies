class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :shared_by_id, null: false, foreign_key: true
      t.text :description
      t.string :thumbnail
      t.string :link

      t.timestamps
    end
  end
end
