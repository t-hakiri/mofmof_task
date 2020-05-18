class CreateJoinGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :join_groups do |t|
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
