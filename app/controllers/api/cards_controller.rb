class Api::CardsController < ApplicationController
  def index
    p current_user
    if current_store
      @cards = current_store.cards
      render 'index.json.jbuilder'
    elsif current_user
      @cards = current_user.cards
      render 'index.json.jbuilder'
    else
      render json: {message: "Unauthorized"}
    end
  end

  def show
    @card = Card.find(params[:id])
    render 'show.json.jbuilder'
  end

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

      stat = Stat.new(
        runs: params[:stats][:runs],
        hits: params[:stats][:hits],
        ba: params[:stats][:ba],
        hr: params[:stats][:hr],
        sb: params[:stats][:sb],
        year_played: params[:stats][:year_played],
        card_id: @card.id
      )

      stat.save
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
        user_id: current_store.users[0].id,
        store_id: current_store.id,
        # store_id: current_store.id || current_user.store,
        confirmed: params[:confirmed] || false,
        value: params[:value],
      )

      stat = Stat.find(params[:stats][:id])
      stat.update(
        runs: params[:stats][:runs],
        hits: params[:stats][:hits],
        ba: params[:stats][:ba],
        hr: params[:stats][:hr],
        sb: params[:stats][:sb],
        year_played: params[:stats][:year_played],
        card_id: @card.id
      )
      render 'show.json.jbuilder'
    else
      render json: {}
    end
  end
end


