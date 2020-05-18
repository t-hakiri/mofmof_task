class AddColomnGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :organizer_id, :integer
  end
end
