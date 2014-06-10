json.array!(@items) do |item|
  json.id item.ID
  json.serial item.SerialNumber
  json.dealer item.dealer.name
end
