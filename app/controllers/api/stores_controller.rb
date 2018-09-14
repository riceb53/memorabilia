class Api::StoresController < ApplicationController
  def index
    @stores = Store.all
    render 'index.json.jbuilder'
  end

  def create
    @store = Store.new(
      title: params[:title],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      email: params[:email],
      address: params[:address],
      city: params[:city],
      zip_code: params[:zip_code]
    )
    # must assign state_id based on zip
    zip_code = ZipCode.find_by(value: @store.zip_code)
    @store.state_id = zip_code.state.id
    if @store.save
      render "show.json.jbuilder"
    else
      render json: {errors: @store.errors.full_messages}, status: :unprocessable_entity
    end
  end
end
