json.array!(@links) do |link|
  json.extract! link, :url, :user_id, :private, :description
  json.url link_url(link, format: :json)
end
