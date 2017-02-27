class CreateTrackers < ActiveRecord::Migration[5.0]
  def change
    create_table :trackers do |t|
      t.string :first_name
      t.string :string
      t.string :last_name
      t.string :grade
      t.string :comments

      t.timestamps
    end
  end
end
