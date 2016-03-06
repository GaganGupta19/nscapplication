class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :team_id
      t.integer :event_id
      t.integer :round

      t.timestamps null: false
    end
  end
end
