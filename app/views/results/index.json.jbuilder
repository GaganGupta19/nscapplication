json.array!(@results) do |result|
  json.extract! result, :id, :team_id, :event_id, :round
  json.url result_url(result, format: :json)
end
