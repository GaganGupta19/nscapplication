class ParticipantAttendance < ActiveRecord::Base
  belongs_to :team
  belongs_to :participant
  belongs_to :event
end
