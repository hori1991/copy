class RemoveUserIdFromRelationships < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :relationships, :users
    remove_index :relationships, :user_id
  end
end
