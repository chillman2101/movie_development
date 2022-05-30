class WelcomeController < ApplicationController
  before_action :set_genre_producer, only: [:new, :edit, :update, :create]
  def index
  end
  def new; end
  def get_datafilm
    # @film = Film.includes(:genre,:producer).all
   @film = Film.joins("INNER JOIN genres ON genres.id = films.genre_id INNER JOIN producers ON producers.id = films.producer_id ").includes(:genre,:producer)
    
    # render :json => @film.to_json(:include=>[:genre,:producer])
    render :json => @film.to_json(:include=>[:genre,:producer])
    
  end
  def create
    @film = Film.new(film_params)
    if @film.save
      redirect_to root_path, notice: 'Successfully add movie'
    else
      redirect_to add_movie_path, notice: "Invalid Format #{@film.errors.full_messages.to_sentence}"
    end
  end

  def edit
    @film = Film.includes(:genre, :producer).find(params[:id])
  end

  def update
    @film = Film.find(params[:id])
    # logger.debug "Log Film: #{@film.inspect}"
    if @film.update(film_params_edit)
      logger.debug "Log Film: #{film_params.inspect}"
      redirect_to root_path, notice: 'Successfully Edit Movie'
    else
      redirect_to edit_movie_path, notice: "Invalid Format #{@film.errors.full_messages.to_sentence}"
    end
  end

  def destroy
    @film = Film.find(params[:id])
    if @film.destroy
      redirect_to root_path, notice: "Movie '#{@film.title}' has been destroyed"
    else
      redirect_to root_path, notice: "Invalid Format #{@film.errors.full_messages.to_sentence}"
    end
  end
  
  private
  def film_params
    # strong parameters
    params.permit(:title, :release_date, :rating, :genre_id, :producer_id)
  end
  def film_params_edit
    # strong parameters
    params.require(:film).permit(:title, :release_date, :rating, :genre_id, :producer_id)
  end
  def set_genre_producer
    @genre = Genre.all
    @producer = Producer.all
  end
end
