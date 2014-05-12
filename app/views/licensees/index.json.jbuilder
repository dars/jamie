json.array!(@licensees) do |licensee|
  json.extract! licensee, :id
  json.url licensee_url(licensee, format: :json)
end
