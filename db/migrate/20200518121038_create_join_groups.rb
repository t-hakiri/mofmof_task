class CreateJoinGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :join_groups do |t|
      t.references :group, foreign_key: true
      t.references :member, foreign_key: true
      t.boolean :organizer, default: false

      t.timestamps
    end
  end
end
