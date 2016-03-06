class CreateTeamDetails < ActiveRecord::Migration
  def change
    create_table :team_details do |t|
      t.references :team, index: true, foreign_key: true
      t.references :participant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
