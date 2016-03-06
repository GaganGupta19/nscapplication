class CreateParticipantAttendances < ActiveRecord::Migration
  def change
    create_table :participant_attendances do |t|
      t.references :team, index: true, foreign_key: true
      t.references :participant, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.integer :round
      t.string :status

      t.timestamps null: false
    end
  end
end
