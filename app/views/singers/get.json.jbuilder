json.array!(@items) do |item|
  json.extract! item, :ID, :SingerNameT
  # json.url get_url(item, format: :json)
end
