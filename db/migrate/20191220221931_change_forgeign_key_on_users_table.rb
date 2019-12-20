class ChangeForgeignKeyOnUsersTable < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :games, column: :user_id
    remove_foreign_key :reviews, column: :user_id
    remove_foreign_key :reviews, column: :game_id
    add_foreign_key :games, :users, column: :user_id, on_delete: :cascade
    add_foreign_key :reviews, :users, column: :user_id, on_delete: :cascade
    add_foreign_key :reviews, :games, column: :game_id, on_delete: :cascade
  end
end
