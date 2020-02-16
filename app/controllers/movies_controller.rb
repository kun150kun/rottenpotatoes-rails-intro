class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    if not session.key?(:checked_rating)
      Movie.checked_ratings = @all_ratings
    end
    @checked_rating = params[:ratings].present? ? params[:ratings].keys : Movie.checked_ratings
    @movies = Movie.with_rating(@checked_rating)
    Movie.checked_ratings = @checked_rating

    col = params[:sort]
    @movies = @movies.order(col)
    if col == "title"
      @css_title_class = "hilite"
      @css_release_data_class = ""
    elsif col == "release_date"
      @css_title_class = ""
      @css_release_data_class = "hilite"
    else
      @css_title_class = ""
      @css_release_data_class = ""
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
