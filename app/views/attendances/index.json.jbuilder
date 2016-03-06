json.array!(@attendances) do |attendance|
  json.extract! attendance, :id, :team_id, :event_id, :round, :status
  json.url attendance_url(attendance, format: :json)
end
