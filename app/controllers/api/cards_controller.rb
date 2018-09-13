class Api::CardsController < ApplicationController
  def create
    if current_user || current_store
      @card = Card.new(
        year_made: params[:year_made],
        player: params[:player],
        quality: params[:quality],
        notes: params[:notes],
        user_id: current_user.id,
        # user_id: current_user.id || current_store.user.id,
        store_id: current_user.stores[0].id,
        # store_id: current_store.id || current_user.store.id,
        confirmed: params[:confirmed] || false,
        value: params[:value],
      )
      @card.save
      render 'show.json.jbuilder'
    else
      render json: {}
    end
  end

  def update
    if current_store
      @card = Card.find(params[:id])
      @card.update(
        year_made: params[:year_made],
        player: params[:player],
        quality: params[:quality],
        notes: params[:notes],
        user_id: current_store.user.id,
        store_id: current_user.stores[0],
        # store_id: current_stores.id || current_user.store,
        confirmed: params[:confirmed] || false,
        value: params[:value],
      )
      render 'show.json.jbuilder'
    else
      render json: {}
    end
  end
end
