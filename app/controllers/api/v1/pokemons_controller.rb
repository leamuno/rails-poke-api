class Api::V1::PokemonsController < ApplicationController
  def index
    if params[:title].present?
      @pokemons = Pokemon.where('name ILIKE ?', "%#{params[:title]}%")
    else
      @pokemons = Pokemon.all
    end
    # Putting the most recently created pokemons first
    render json: @pokemons.order(created_at: :asc)
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    if @pokemon.save
      render json: @pokemon, status: :created
    else
      render json: { error: @pokemon.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :encounter, :pictures, types: [])
  end
end
