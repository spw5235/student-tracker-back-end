class RemoveStringFromTracker < ActiveRecord::Migration[5.0]
  def change
    remove_column :trackers, :string, :string
  end
end
