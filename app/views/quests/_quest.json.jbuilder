json.extract! quest, :id, :title, :description, :completed_at, :start_at, :end_at, :created_at, :updated_at
json.url quest_url(quest, format: :json)
