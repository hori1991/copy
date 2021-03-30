class RemoveFollowIdFromRelationships < ActiveRecord::Migration[6.0]
  def change
    remove_index :relationships, column: :follow_id, name: 'index_relationships_on_follow_id'
    remove_index :relationships, column: :follow_id, name: 'index_relationships_on_user_id_and_follow_id'
    remove_column :relationships, :follow_id, :bigint
  end
end
