class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :name
      t.string :genre
      t.string :company
      t.string :system
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
