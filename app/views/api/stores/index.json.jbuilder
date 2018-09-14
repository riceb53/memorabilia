json.array! @stores do |store|
  json.id store.id
  json.title store.title
  json.email store.email
  json.address store.address
  json.city store.city
  json.state_id store.state_id
  json.zip_code store.zip_code
  json.state store.state
end
