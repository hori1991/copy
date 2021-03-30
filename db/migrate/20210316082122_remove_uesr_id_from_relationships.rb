class RemoveUesrIdFromRelationships < ActiveRecord::Migration[6.0]
  def change
    remove_column :relationships, :user_id, :bigint
  end
end
