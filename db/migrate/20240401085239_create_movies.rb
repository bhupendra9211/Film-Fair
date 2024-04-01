class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :movie_id
      t.string :original_title
      t.string :genera
      t.string :overview
      t.string :popularity
      t.string :budget
      t.string :poster
      
      t.timestamps
    end
  end
end
