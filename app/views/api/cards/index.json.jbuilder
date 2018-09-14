json.array! @cards do |card|
  json.id card.id
  json.year_made card.year_made
  json.player card.player
  json.quality card.quality
  json.notes card.notes
  json.user_id card.user_id
  json.store_id card.store_id
  json.confirmed card.confirmed
  json.value card.value
  json.user card.user
end
