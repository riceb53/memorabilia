class Api::SessionsController < ApplicationController
  def create
    if params[:user_type] == "user"
      p "in user"
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        jwt = JWT.encode(
          {
            user: user.id, # the data to encode
            exp: 24.hours.from_now.to_i # the expiration time
          },
          Rails.application.credentials.fetch(:secret_key_base), # the secret key
          'HS256' # the encryption algorithm
        )
        render json: {jwt: jwt, email: user.email}, status: :created
      else
        render json: {}
      end
    elsif params[:user_type] == "store"
      p "in store"
      store = Store.find_by(email: params[:email])
      if store && store.authenticate(params[:password])
        jwt = JWT.encode(
          {
            store: store.id, # the data to encode
            exp: 24.hours.from_now.to_i # the expiration time
          },
          Rails.application.credentials.fetch(:secret_key_base), # the secret key
          'HS256' # the encryption algorithm
        )
        render json: {jwt: jwt, email: store.email}, status: :created
      else
        render json: {}
      end
    end
  end
end
