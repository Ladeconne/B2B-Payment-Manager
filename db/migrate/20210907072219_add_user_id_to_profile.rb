class AddUserIdToProfile < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :profile_id
    add_reference :profiles, :user, null: false, foreign_key: true
  end
end
