package com.example.netflix.backend.service;

import com.example.netflix.backend.models.Movie;

import java.util.List;

public interface MovieService {
    Movie saveMovie(Movie movie);
    List<Movie> getAllMovies();
    List<Movie> getAllMoviesPaginated(int page, int size);
    Movie getMovieById(Integer id);
    void deleteMovie(Integer id);
    List<Movie> getMoviesByGenre(String genre);
    List<Movie> getMoviesByGenrePaginated(String genre, int page, int size);
    List<Movie> getMoviesByContentType(String contentType);
    List<Movie> searchMoviesByTitle(String keyword);
    List<Movie> searchMoviesByTitlePaginated(String keyword, int page, int size);
    List<Movie> getRecentMovies();
    List<Movie> getMoviesByGenreAndContentType(String genre, String contentType);
    List<Movie> getPopularMovies();
    List<Movie> getTrendingMovies();
    List<Movie> getTopRatedMovies(); // ✅ Add this line
    List<Movie> getUpcomingMovies();

}
