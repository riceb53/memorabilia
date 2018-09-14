class Api::UsersController < ApplicationController
  def index
    if current_store
      @users = current_store.users
    end
    render 'index.json.jbuilder'
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      zip_code: params[:zip_code]
    )
    @type = 'user'
    if @user.save
      zip_code = ZipCode.find_by(value: params[:zip_code])
      state = zip_code.state

      store_user = StoreUser.new(
        user_id: @user.id,
        store_id: state.stores[0].id
      )
      store_user.save
      render "show.json.jbuilder"
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    # p 'current user'
    # p current_user
    # p 'current store'
    # p current_store
    if current_user
      @user = current_user
      @type = 'user'
    elsif current_store
      @user = current_store
      @type = 'store'
    end
    render 'show.json.jbuilder'
  end
end
