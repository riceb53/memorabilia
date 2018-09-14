Rails.application.routes.draw do
  # STEP 1: A ROUTE triggers a controller action
  # verb "/urls" => "namespace/controllers#action"
  namespace :api do
    post "/cards" => "cards#create"
    patch "/cards/:id" => "cards#update"
    post "/users" => "users#create"
    post "/sessions" => "sessions#create"
    post "/stores" => "stores#create"
    get "/users/show" => "users#show"
    get "/cards" => "cards#index"
    get "/cards/:id" => "cards#show"
  end
end
