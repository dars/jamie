json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :password, :sign_in_count, :last_sign_in_at, :last_sign_in_ip, :role, :status
  json.url user_url(user, format: :json)
end
