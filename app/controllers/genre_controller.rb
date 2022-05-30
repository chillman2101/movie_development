class GenreController < ApplicationController
  def index
  end
  def get_datagenre
    @genre = Genre.all
    render :json => @genre.to_json  
   end
   def edit
    @genre = Genre.find(params[:id])
  end

  def new 
  end
    
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genre_path, notice: 'Successfully add Genre'
    else
      redirect_to edit_genre_path, notice: "Invalid Format #{@genre.errors.full_messages.to_sentence}"
    end
  end

  def update
    @genre = Genre.find(params[:id])
    # logger.debug "Log Film: #{@film.inspect}"
    if @genre.update(genre_params_edit)
      logger.debug "Log Film: #{genre_params_edit.inspect}"
      redirect_to genre_path, notice: 'Successfully Edit Genre'
    else
      redirect_to edit_genre_path, notice: "Invalid Format #{@genre.errors.full_messages.to_sentence}"
    end
  end

  # def destroy
  #   @genre = Genre.find(params[:id])
  #   if @genre.destroy
  #     redirect_to genre_path, notice: "Genre '#{@genre.name}' has been destroyed"
  #   else
  #     redirect_to edit_genre_path, notice: "Invalid Format #{@genre.errors.full_messages.to_sentence}"
  #   end
  # end

  private
  def genre_params_edit
    # strong parameters
    params.require(:genre).permit(:name,:description)
  end
  def genre_params
    # strong parameters
    params.permit(:name,:description)
  end
end
