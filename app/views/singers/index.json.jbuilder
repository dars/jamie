json.array!(@singers) do |singer|
  json.extract! singer, :id
  json.url singer_url(singer, format: :json)
end
