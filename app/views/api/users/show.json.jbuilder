if @type
  json.type @type
end
json.info do
  json.id @user.id
  if @type == 'user'
    json.name @user.name
  else
    json.title @user.title
  end
  json.email @user.email
end
