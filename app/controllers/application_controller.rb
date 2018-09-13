class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def current_user
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last
      begin
        decoded_token = JWT.decode(
          token,
          Rails.application.credentials.fetch(:secret_key_base),
          true,
          { algorithm: 'HS256' }
        )
        User.find_by(id: decoded_token[0]["user"])
      rescue JWT::ExpiredSignature
        nil
      end
    end
  end

  helper_method :current_user

  def authenticate_user
    unless current_user
      render json: {}, status: :unauthorized
    end
  end


  def current_store
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last
      begin
        decoded_token = JWT.decode(
          token,
          Rails.application.credentials.fetch(:secret_key_base),
          true,
          { algorithm: 'HS256' }
        )
        Store.find_by(id: decoded_token[0]["store"])
      rescue JWT::ExpiredSignature
        nil
      end
    end
  end

  helper_method :current_store

  def authenticate_store
    unless current_store
      render json: {}, status: :unauthorized
    end
  end
end
